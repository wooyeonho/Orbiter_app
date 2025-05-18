import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

class ApiService {
  static final _supabase = Supabase.instance.client;
  static final _openaiKey = dotenv.env['OPENAI_API_KEY'] ?? '';

  static Future<String> gptRoutine(String emotion) async {
    final res = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Authorization': 'Bearer $_openaiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'model': 'gpt-4o-mini',
        'messages': [
          {'role': 'system', 'content': 'You are a helpful coach.'},
          {'role': 'user', 'content': 'I feel $emotion. Recommend one helpful routine in JSON {emotion,title,description,estimated_minutes}'}
        ],
        'temperature': 0.7,
      }),
    );
    if (res.statusCode != 200) throw Exception('GPT error ${res.statusCode}');
    return jsonDecode(res.body)['choices'][0]['message']['content'];
  }

  static Future<void> save(String table, Map<String, dynamic> data) async {
    await _supabase.from(table).insert(data);
  }
}
