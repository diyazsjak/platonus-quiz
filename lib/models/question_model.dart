class QuestionModel {
  final String question;
  final Map<int, String> variants;
  int? selectedVariant;

  QuestionModel({
    required this.question,
    required this.variants,
    this.selectedVariant,
  });
}
