import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platonus_quiz/bloc/quiz/quiz_bloc.dart';

import '../models/question_model.dart';

class QuestionCard extends StatefulWidget {
  final QuestionModel question;

  const QuestionCard({super.key, required this.question});

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  late int? _selectedVariant = widget.question.selectedVariant;
  late bool _isQuestionAnswered = widget.question.isQuestionAnswered;

  void _onVariantSelected(int variant) {
    if (_isQuestionAnswered) return;

    setState(() {
      _selectedVariant = variant;
      widget.question.selectedVariant = variant;
    });
  }

  void _onQuestionAnswered() {
    if (_isQuestionAnswered) return;
    setState(() => _isQuestionAnswered = true);
    context.read<QuizBloc>().add(QuizQuestionAnswered(widget.question));
  }

  Widget _buildVariant(MapEntry<int, String> variant) {
    final variantText =
        '${variant.value[0].toUpperCase()}${variant.value.substring(1)}';

    Color radioColor = Theme.of(context).colorScheme.secondary;
    int? groupValue = _selectedVariant;

    if (_isQuestionAnswered) {
      if (variant.key == 1) {
        groupValue = 1;
        radioColor = Colors.green;
      }
      if (variant.key == _selectedVariant) {
        radioColor = (variant.key == 1) ? Colors.green : Colors.redAccent;
      }
    }

    return InkWell(
      onTap: () => _onVariantSelected(variant.key),
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Radio<int>(
              value: variant.key,
              groupValue: groupValue,
              activeColor: radioColor,
              onChanged: (int? value) => _onVariantSelected(variant.key),
            ),
            Flexible(child: Text(variantText)),
          ],
        ),
      ),
    );
  }

  Widget _buildVerifyVariantButton() {
    return (_selectedVariant != null)
        ? FilledButton(
            onPressed: _onQuestionAnswered,
            child: const Text('Check answer'),
          )
        : FilledButton.tonal(
            onPressed: () {},
            child: const Text('Check answer'),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.question.question,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            for (final variant in widget.question.variants.entries)
              _buildVariant(variant),
            const SizedBox(height: 16),
            _buildVerifyVariantButton(),
          ],
        ),
      ),
    );
  }
}
