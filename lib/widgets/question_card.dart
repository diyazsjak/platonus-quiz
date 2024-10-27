import 'package:flutter/material.dart';

import '../models/question_model.dart';

class QuestionCard extends StatefulWidget {
  final QuestionModel question;

  const QuestionCard({super.key, required this.question});

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  late int? _selectedVariant = widget.question.selectedVariant;

  void _onVariantSelected(int variant) {
    setState(() {
      _selectedVariant = variant;
      widget.question.selectedVariant = variant;
    });
  }

  Widget _buildVariant(MapEntry<int, String> variant) {
    final variantText =
        '${variant.value[0].toUpperCase()}${variant.value.substring(1)}';

    return GestureDetector(
      onTap: () => _onVariantSelected(variant.key),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            Radio<int>(
              value: variant.key,
              groupValue: _selectedVariant,
              onChanged: (int? value) => _onVariantSelected(variant.key),
            ),
            Flexible(child: Text(variantText)),
          ],
        ),
      ),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.question.question,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            for (final variant in widget.question.variants.entries)
              _buildVariant(variant),
          ],
        ),
      ),
    );
  }
}
