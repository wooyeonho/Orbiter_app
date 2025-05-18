import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core.dart';
import 'screens/start_screen.dart';
import 'screens/status_input_screen.dart';
import 'screens/routine_result_screen.dart';
import 'screens/routine_feedback_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  if ((dotenv.env['SUPABASE_URL']?.isEmpty ?? true) ||
      (dotenv.env['SUPABASE_ANON_KEY']?.isEmpty ?? true)) {
    throw Exception('환경변수(Supabase)가 설정되지 않았어요');
  }
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  runApp(const OrbiterApp());
}

class OrbiterApp extends StatelessWidget {
  const OrbiterApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Orbiter',
        theme: orbiterTheme,
        initialRoute: StartScreen.routeName,
        routes: {
          StartScreen.routeName: (_) => const StartScreen(),
          StatusInputScreen.routeName: (_) => const StatusInputScreen(),
          RoutineResultScreen.routeName: (_) => const RoutineResultScreen(),
          RoutineFeedbackScreen.routeName: (_) => const RoutineFeedbackScreen(),
        },
      );
