import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class QuestionCardVariant extends StatelessWidget {
  final Function(int) onSelected;
  final MapEntry<int, String> variant;
  final int? selectedVariant;
  final bool isQuestionAnswered;

  const QuestionCardVariant({
    super.key,
    required this.onSelected,
    required this.variant,
    required this.selectedVariant,
    required this.isQuestionAnswered,
  });

  String capitalizeVariant(String variant) {
    return '${variant[0].toUpperCase()}${variant.substring(1)}';
  }

  @override
  Widget build(BuildContext context) {
    Color radioColor = Theme.of(context).colorScheme.secondary;
    int? groupValue = selectedVariant;

    if (isQuestionAnswered) {
      if (variant.key == 1) {
        groupValue = 1;
        radioColor = Colors.green;
      } else {
        radioColor = Colors.redAccent;
      }
    }

    return InkWell(
      onTap: () => onSelected(variant.key),
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Skeleton.shade(
              child: Radio<int>(
                value: variant.key,
                groupValue: groupValue,
                activeColor: radioColor,
                onChanged: (_) => onSelected(variant.key),
              ),
            ),
            Flexible(child: Text(capitalizeVariant(variant.value))),
          ],
        ),
      ),
    );
  }
}
