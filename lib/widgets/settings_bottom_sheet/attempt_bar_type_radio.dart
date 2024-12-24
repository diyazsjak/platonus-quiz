import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/attempt_bar_type/attempt_bar_type_cubit.dart';
import '../home_screen/bar_chart_painters.dart';

class AttemptBarTypeRadio extends StatefulWidget {
  const AttemptBarTypeRadio({super.key});

  @override
  State<AttemptBarTypeRadio> createState() => _AttemptBarTypeRadioState();
}

class _AttemptBarTypeRadioState extends State<AttemptBarTypeRadio> {
  late AttemptBarType _selectedType =
      context.read<AttemptBarTypeCubit>().currentType!;

  void _onTypeChanged(AttemptBarType? type) {
    if (_selectedType == type) return;
    setState(() => _selectedType = type!);
    context.read<AttemptBarTypeCubit>().changeType(type!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Attempt bar type',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _RadioContainer(
                AttemptBarType.withBackground,
                _selectedType,
                _onTypeChanged,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _RadioContainer(
                AttemptBarType.withoutBackground,
                _selectedType,
                _onTypeChanged,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _RadioContainer extends StatelessWidget {
  final AttemptBarType value;
  final AttemptBarType groupValue;
  final Function(AttemptBarType?) onChanged;

  const _RadioContainer(this.value, this.groupValue, this.onChanged);

  @override
  Widget build(BuildContext context) {
    final barWidth = 20.0;
    final fullBarHeight = 100.0;
    final barColor = Theme.of(context).colorScheme.primary;
    final barBgColor = Theme.of(context).colorScheme.primaryContainer;

    return GestureDetector(
      onTap: () => onChanged(value),
      child: Card(
        elevation: (value == groupValue) ? 3 : 1,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Radio<AttemptBarType>(
                value: value,
                groupValue: groupValue,
                onChanged: onChanged,
              ),
            ),
            SizedBox(
              height: fullBarHeight,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: NeverScrollableScrollPhysics(),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(5, (index) {
                    final score = 20 * (index + 1);

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: CustomPaint(
                        size: Size(barWidth, fullBarHeight),
                        painter: (value == AttemptBarType.withoutBackground)
                            ? BarChartWithoutBgPainter(
                                score: score,
                                height: fullBarHeight,
                                width: barWidth,
                                fgColor: barColor,
                              )
                            : BarChartWithBgPainter(
                                score: score,
                                height: fullBarHeight,
                                width: barWidth,
                                bgColor: barBgColor,
                                fgColor: barColor,
                              ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
