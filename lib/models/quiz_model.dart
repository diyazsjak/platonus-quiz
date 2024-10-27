import 'question_model.dart';

class QuizModel {
  final String quizName;
  final List<QuestionModel> questions;

  QuizModel({required this.quizName, required this.questions});
}
