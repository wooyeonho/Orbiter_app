import 'package:uuid/uuid.dart';

enum Emotion { happy, sad, calm, angry, stressed, excited }

class Routine {
  final String id;
  final String emotion;
  final String title;
  final String description;
  final int estimatedMinutes;

  Routine({
    required this.id,
    required this.emotion,
    required this.title,
    required this.description,
    required this.estimatedMinutes,
  });

  factory Routine.fromJson(Map<String, dynamic> j) => Routine(
        id: j['id'] ?? const Uuid().v4(),
        emotion: j['emotion'],
        title: j['title'],
        description: j['description'],
        estimatedMinutes: j['estimated_minutes'] ?? j['estimatedMinutes'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'emotion': emotion,
        'title': title,
        'description': description,
        'estimated_minutes': estimatedMinutes,
      };
}

class FeedbackRecord {
  final String id;
  final String routineId;
  final double satisfaction;
  final String reflection;
  final DateTime completedAt;

  FeedbackRecord({
    required this.id,
    required this.routineId,
    required this.satisfaction,
    required this.reflection,
    required this.completedAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'routine_id': routineId,
        'satisfaction_score': satisfaction,
        'reflection_text': reflection,
        'completed_at': completedAt.toIso8601String(),
      };
}
