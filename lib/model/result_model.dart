enum QuestionStatus {correct, wrong, skipped}

class ResultModel {
  double? percentage;
  String? timeTaken;
  int? correct;
  int? skipped;
  int? wrong;
  int? attemptsLeft;
  List<QuestionStatus>? questionResults;

  ResultModel({
    required this.percentage,
    required this.attemptsLeft,
    required this.correct,
    required this.skipped,
    required this.timeTaken,
    required this.wrong,
    required this.questionResults,
  });
}
