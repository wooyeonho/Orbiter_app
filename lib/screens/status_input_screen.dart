import 'package:flutter/material.dart';
import '../core.dart';
import '../models.dart';
import 'routine_result_screen.dart';

class StatusInputScreen extends StatefulWidget {
  static const routeName = '/status';
  const StatusInputScreen({super.key});

  @override
  State<StatusInputScreen> createState() => _StatusInputScreenState();
}

class _StatusInputScreenState extends State<StatusInputScreen> {
  Emotion _emotion = Emotion.happy;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('감정 상태 입력')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<Emotion>(
              value: _emotion,
              items: Emotion.values
                  .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                  .toList(),
              onChanged: (v) => setState(() => _emotion = v ?? Emotion.happy),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
              onPressed: () => Navigator.pushNamed(
                context,
                RoutineResultScreen.routeName,
                arguments: _emotion.name,
              ),
              child: const Text('루틴 추천받기'),
            ),
          ],
        ),
      );
