import 'package:flutter/material.dart';
import '../core.dart';
import 'status_input_screen.dart';

class StartScreen extends StatelessWidget {
  static const routeName = '/';
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Orbiter')),
        body: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
            onPressed: () => Navigator.pushNamed(context, StatusInputScreen.routeName),
            child: const Text('시작하기'),
          ),
        ),
      );
