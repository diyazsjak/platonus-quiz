import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class QuestionCardVariant extends StatefulWidget {
  final Function(int) onSelected;
  final MapEntry<int, String> variant;
  final int? groupValue;
  final bool isQuestionAnswered;

  const QuestionCardVariant({
    super.key,
    required this.onSelected,
    required this.variant,
    required this.groupValue,
    required this.isQuestionAnswered,
  });

  @override
  State<QuestionCardVariant> createState() => _QuestionCardVariantState();
}

class _QuestionCardVariantState extends State<QuestionCardVariant> {
  String capitalizeVariant(String variant) {
    return '${variant[0].toUpperCase()}${variant.substring(1)}';
  }

  @override
  Widget build(BuildContext context) {
    Color radioColor = Theme.of(context).colorScheme.secondary;
    int? groupValue = widget.groupValue;

    if (widget.isQuestionAnswered) {
      if (widget.variant.key == 1) {
        groupValue = 1;
        radioColor = Colors.green;
      }
      if (widget.variant.key == widget.groupValue) {
        radioColor =
            (widget.variant.key == 1) ? Colors.green : Colors.redAccent;
      }
    }

    return InkWell(
      onTap: () => widget.onSelected(widget.variant.key),
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Skeleton.shade(
              child: Radio<int>(
                value: widget.variant.key,
                groupValue: groupValue,
                activeColor: radioColor,
                onChanged: (_) => widget.onSelected(widget.variant.key),
              ),
            ),
            Flexible(child: Text(capitalizeVariant(widget.variant.value))),
          ],
        ),
      ),
    );
  }
}
