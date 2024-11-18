import '../core/database.dart';
import 'question_model.dart';

class QuizModel {
  final String quizName;
  final List<QuestionModel> questions;

  QuizModel({required this.quizName, required this.questions});

  int getRightAnsweredQuestions() {
    int rightAnsweredQuestions = 0;

    for (final question in questions) {
      if (question.selectedVariant == 1) {
        rightAnsweredQuestions++;
      }
    }

    return rightAnsweredQuestions;
  }

  factory QuizModel.fromDatabase(QuizData quiz, List<QuestionData> questions) {
    final questionModels = <QuestionModel>[];
    for (final question in questions) {
      final questionModel = QuestionModel.fromDatabase(question);
      questionModels.add(questionModel);
    }

    return QuizModel(quizName: quiz.name, questions: questionModels);
  }
}
