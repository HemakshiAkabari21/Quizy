import 'package:quizy/model/result_model.dart';

class QuizModel{
  String? question;
  List<Answer>? answer;
  String? userAnswer;
  String? correctAnswer;
  QuestionStatus? questionStatus;

  QuizModel({required this.question,required this.answer,required this.userAnswer,this.questionStatus,this.correctAnswer});

}

class Answer {
  String? answer;
  Answer({this.answer});
}