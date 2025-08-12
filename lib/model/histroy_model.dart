class HistoryModel {

  final String dayTime;
  final String topic;
  final int percentage;
  final int correctAnswer;
  final int skippedAnswer;
  final int wrongAnswer;
  final String timeTaken;

  HistoryModel({
    required this.dayTime,
    required this.topic,
    required this.percentage,
    required this.correctAnswer,
    required this.skippedAnswer,
    required this.wrongAnswer,
    required this.timeTaken,
  });
}
