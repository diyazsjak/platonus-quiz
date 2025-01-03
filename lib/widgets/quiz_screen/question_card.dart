import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/quiz/quiz_bloc.dart';
import '../../models/question_model.dart';
import 'quesiton_card_variant.dart';

class QuestionCard extends StatefulWidget {
  final int count;
  final QuestionModel question;

  const QuestionCard({super.key, required this.question, required this.count});

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  late int? _selectedVariant = widget.question.selectedVariant;
  late bool _isQuestionAnswered = widget.question.isQuestionAnswered;

  void _onVariantSelected(int variant) {
    if (_isQuestionAnswered) return;
    setState(() => _selectedVariant = variant);
    context.read<QuizBloc>().add(QuizVariantSelected(widget.question, variant));
  }

  void _onQuestionAnswered() {
    if (_isQuestionAnswered) return;
    setState(() => _isQuestionAnswered = true);
    context.read<QuizBloc>().add(QuizQuestionAnswered(widget.question));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '${widget.count}) ${widget.question.question}',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            for (final variant in widget.question.variants.entries)
              QuestionCardVariant(
                onSelected: _onVariantSelected,
                variant: variant,
                selectedVariant: _selectedVariant,
                isQuestionAnswered: _isQuestionAnswered,
              ),
            const SizedBox(height: 16),
            _CheckVariantButton(
              isVariantSelected: _selectedVariant != null,
              onQuestionAnswered: _onQuestionAnswered,
            ),
          ],
        ),
      ),
    );
  }
}

class _CheckVariantButton extends StatelessWidget {
  final bool isVariantSelected;
  final VoidCallback onQuestionAnswered;

  const _CheckVariantButton({
    required this.isVariantSelected,
    required this.onQuestionAnswered,
  });

  @override
  Widget build(BuildContext context) {
    return (isVariantSelected)
        ? FilledButton(
            onPressed: onQuestionAnswered,
            child: const Text('Check answer'),
          )
        : FilledButton.tonal(
            onPressed: () {},
            child: const Text('Check answer'),
          );
  }
}
