import '../core/database.dart';
import '../services/quiz_parser_service.dart';

class QuestionModel {
  final int id;
  final String question;
  final Map<int, String> variants;
  int? selectedVariant;
  bool isQuestionAnswered;

  QuestionModel({
    required this.id,
    required this.question,
    required this.variants,
    this.selectedVariant,
    this.isQuestionAnswered = false,
  });

  factory QuestionModel.fromDatabase(QuestionData questionData) {
    return QuestionModel(
      id: questionData.id,
      question: questionData.question,
      variants: QuizParserService.getShuffledVariantsMapFromString(
        questionData.variants,
      ),
    );
  }
}
