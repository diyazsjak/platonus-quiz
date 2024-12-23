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
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Card(
        elevation: (value == groupValue) ? 3 : 1,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Radio<AttemptBarType>(
                  value: value,
                  groupValue: groupValue,
                  onChanged: onChanged,
                ),
              ),
              SizedBox(
                height: 100,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      5,
                      (index) {
                        return (value == AttemptBarType.withoutBackground)
                            ? _BarWithoutBackground(20 * (index + 1))
                            : _BarWithBackground(20 * (index + 1));
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BarWithBackground extends StatelessWidget {
  final int score;

  const _BarWithBackground(this.score);

  @override
  Widget build(BuildContext context) {
    final width = 20.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return CustomPaint(
            size: Size(width, constraints.maxHeight),
            painter: BarChartWithBgPainter(
              score: score,
              height: constraints.maxHeight,
              width: width,
              bgColor: Theme.of(context).colorScheme.primaryContainer,
              fgColor: Theme.of(context).colorScheme.primary,
            ),
          );
        },
      ),
    );
  }
}

class _BarWithoutBackground extends StatelessWidget {
  final int score;

  const _BarWithoutBackground(this.score);

  @override
  Widget build(BuildContext context) {
    final width = 20.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return CustomPaint(
            size: Size(width, constraints.maxHeight),
            painter: BarChartWithoutBgPainter(
              score: score,
              height: constraints.maxHeight,
              width: width,
              bgColor: Theme.of(context).colorScheme.primaryContainer,
              fgColor: Theme.of(context).colorScheme.primary,
            ),
          );
        },
      ),
    );
  }
}
