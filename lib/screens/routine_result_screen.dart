import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../core.dart';
import '../api_service.dart';
import '../models.dart';
import 'routine_feedback_screen.dart';

class RoutineResultScreen extends StatefulWidget {
  static const routeName = '/routine';
  const RoutineResultScreen({super.key});

  @override
  State<RoutineResultScreen> createState() => _RoutineResultScreenState();
}

class _RoutineResultScreenState extends State<RoutineResultScreen> {
  Routine? _routine;
  bool _loading = true;
  String? _error;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final emotion = ModalRoute.of(context)!.settings.arguments as String;
    _fetchRoutine(emotion);
  }

  Future<void> _fetchRoutine(String emotion) async {
    try {
      final raw = await ApiService.gptRoutine(emotion);
      final jsonData = jsonDecode(raw);
      final routine = Routine.fromJson({...jsonData, 'emotion': emotion, 'id': const Uuid().v4()});
      await ApiService.save('routines', routine.toJson());
      setState(() => _routine = routine);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(appBar: AppBar(), body: Center(child: CircularProgressIndicator()));
    }
    if (_error != null) {
      return Scaffold(appBar: AppBar(), body: Center(child: Text('루틴 로딩 실패\n$_error', style: bodyStyle)));
    }
    return Scaffold(
      appBar: AppBar(title: const Text('추천 루틴')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_routine!.title, style: headingStyle),
            const SizedBox(height: 8),
            Text(_routine!.description, style: bodyStyle),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
              onPressed: () => Navigator.pushNamed(
                context,
                RoutineFeedbackScreen.routeName,
                arguments: _routine,
              ),
              child: const Text('루틴 실행 후 기록하기'),
            ),
          ],
        ),
      ),
    );
  }
}
