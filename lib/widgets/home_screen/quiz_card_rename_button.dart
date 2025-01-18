import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/quiz_rename/quiz_rename_bloc.dart';

class QuizCardRenameButton extends StatelessWidget {
  final int quizId;

  const QuizCardRenameButton({super.key, required this.quizId});

  void _onRenameTap(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (builderContext) {
        return BlocProvider.value(
          value: BlocProvider.of<QuizRenameBloc>(context),
          child: AnimatedPadding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(builderContext).viewInsets.bottom,
            ),
            duration: Duration(milliseconds: 50),
            curve: Curves.easeOut,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 16),
              child: QuizRenameTextField(quizId: quizId),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () => _onRenameTap(context),
      label: Text('Rename'),
      icon: Icon(Icons.create_outlined),
    );
  }
}

class QuizRenameTextField extends StatefulWidget {
  final int quizId;

  const QuizRenameTextField({super.key, required this.quizId});

  @override
  State<QuizRenameTextField> createState() => _QuizRenameTextFieldState();
}

class _QuizRenameTextFieldState extends State<QuizRenameTextField> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      autofocus: true,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        contentPadding: EdgeInsets.all(16),
        label: Text('New name'),
        suffixIcon: IconButton(
          onPressed: () {
            if (_textController.text.isNotEmpty) {
              context.read<QuizRenameBloc>().add(
                    QuizRenamePressed(
                      quizId: widget.quizId,
                      name: _textController.text.trim(),
                    ),
                  );
            }
          },
          icon: Icon(
            Icons.done,
            color: Theme.of(context).colorScheme.primary,
            size: 28,
          ),
        ),
      ),
    );
  }
}
