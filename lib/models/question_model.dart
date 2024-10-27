class QuestionModel {
  final String question;
  final Map<int, String> variants;
  int? selectedVariant;
  bool isQuestionAnswered;

  QuestionModel({
    required this.question,
    required this.variants,
    this.selectedVariant,
    this.isQuestionAnswered = false,
  });
}
