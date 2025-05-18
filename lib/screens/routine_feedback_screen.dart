import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../core.dart';
import '../api_service.dart';
import '../models.dart';

class RoutineFeedbackScreen extends StatefulWidget {
  static const routeName = '/feedback';
  const RoutineFeedbackScreen({super.key});

  @override
  State<RoutineFeedbackScreen> createState() => _RoutineFeedbackScreenState();
}

class _RoutineFeedbackScreenState extends State<RoutineFeedbackScreen> {
  double _satisfaction = 3;
  final _reflection = TextEditingController();
  bool _saving = false;

  Future<void> _submit(Routine r) async {
    setState(() => _saving = true);
    final info = await PackageInfo.fromPlatform();
    final record = FeedbackRecord(
      id: const Uuid().v4(),
      routineId: r.id,
      satisfaction: _satisfaction,
      reflection: _reflection.text,
      completedAt: DateTime.now(),
    );
    try {
      await ApiService.save('feedback', record.toJson());
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(content: Text('저장 완료!')),
      );
    } catch (e) {
      if (!mounted) return;
      showDialog(context: context, builder: (_) => AlertDialog(content: Text('저장 실패: $e')));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final routine = ModalRoute.of(context)!.settings.arguments as Routine;
    return Scaffold(
      appBar: AppBar(title: const Text('루틴 피드백')),
      body: _saving
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(routine.title, style: headingStyle),
                  const Divider(),
                  Row(
                    children: [
                      const Text('만족도'),
                      Expanded(
                        child: Slider(
                          value: _satisfaction,
                          min: 1,
                          max: 5,
                          divisions: 4,
                          label: _satisfaction.toString(),
                          onChanged: (v) => setState(() => _satisfaction = v),
                        ),
                      ),
                    ],
                  ),
                  TextField(
                    controller: _reflection,
                    maxLines: 4,
                    decoration: const InputDecoration(labelText: '회고 메모'),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                    onPressed: () => _submit(routine),
                    child: const Text('저장'),
                  ),
                ],
              ),
            ),
    );
  }
}
