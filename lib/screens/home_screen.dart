import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/quiz/ongoing_quiz_bloc.dart';
import '../bloc/quizes/quizes_list_bloc.dart';
import '../core/constants.dart';
import '../core/failure.dart';
import '../util/show_snackbar.dart';
import '../widgets/quizes_list.dart';
import '../widgets/settings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _selectFile(BuildContext context) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['doc', 'docx'],
    );

    if (result != null) {
      if (!context.mounted) return;
      final filePath = result.files.first.path!;
      context
          .read<OngoingQuizBloc>()
          .add(OngoingQuizFileSelected(filePath: filePath));
    }
  }

  void _showSettingsBottomSheet(BuildContext context) {
    showModalBottomSheet(context: context, builder: (_) => const Settings());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OngoingQuizBloc, OngoingQuizState>(
      listener: (BuildContext context, state) async {
        if (state is OngoingQuizLoadInProgress) {
          Navigator.of(context).pushNamed(Constants.quizRoute);
        } else if (state is OngoingQuizLoadFailure) {
          Navigator.pop(context);
          (state.failure is WrongQuizFormatFailure)
              ? showErrorSnackbar(context, 'Wrong quiz format')
              : showErrorSnackbar(context, 'Couldn\'t load quiz');
        } else if (state is OngoingQuizLoadSuccess) {
          if (state.isQuizSaved) {
            context.read<QuizesListBloc>().add(QuizesListStarted());
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
              onPressed: () => _showSettingsBottomSheet(context),
              icon: const Icon(Icons.settings),
            )
          ],
        ),
        body: const QuizesList(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _selectFile(context),
          icon: const Icon(Icons.file_open_outlined),
          label: const Text('Select file'),
        ),
      ),
    );
  }
}
