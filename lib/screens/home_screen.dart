import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/attempt_bar_type/attempt_bar_type_cubit.dart';
import '../bloc/file_quiz/file_quiz_bloc.dart';
import '../bloc/quiz/quiz_bloc.dart';
import '../bloc/quizes_list/quizes_list_bloc.dart';
import '../core/constants.dart';
import '../core/failure.dart';
import '../util/loading.dart';
import '../util/show_snackbar.dart';
import '../widgets/home_screen/quizes_list.dart';
import 'settings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _selectFile(BuildContext context) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['docx'],
    );

    if (result != null) {
      if (!context.mounted) return;
      final filePath = result.files.first.path!;
      context.read<FileQuizBloc>().add(FileQuizSelected(filePath));
    }
  }

  void _showSettingsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => BlocProvider.value(
        value: BlocProvider.of<AttemptBarTypeCubit>(context),
        child: const Settings(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<QuizBloc, QuizState>(
          listener: (BuildContext context, state) {
            if (state is QuizLoadInProgress) {
              if (!state.isRestarted) {
                Navigator.of(context).pushNamed(Constants.quizRoute);
              }
            } else if (state is QuizLoadFailure) {
              Navigator.popUntil(
                context,
                ModalRoute.withName(Constants.homeRoute),
              );
              showErrorSnackbar(context, 'Couldn\'t load quiz');
            } else if (state is QuizLoadSuccess) {
              context.read<QuizesListBloc>().add(QuizesListStarted());
            }
          },
        ),
        BlocListener<FileQuizBloc, FileQuizState>(
          listener: (BuildContext context, state) {
            if (state is FileQuizSaveInProgress) {
              Loading.show(context);
            } else if (state is FileQuizSaveFailure) {
              Loading.remove(context);

              String failure = 'Couldn\'t save quiz';
              if (state.failure is WrongFileFormatFailure) {
                failure = 'File should be with .docx extension';
              } else if (state.failure is WrongQuizFormatFailure) {
                failure = 'Quiz should be in <question><variant> format';
              } else if (state.failure is QuizAlreadyExistsFailure) {
                failure = 'Quiz with this name already exists';
              }
              showErrorSnackbar(context, failure);
            } else if (state is FileQuizSaveSuccess) {
              context.read<QuizesListBloc>().add(QuizesListStarted());
              Loading.remove(context);
            }
          },
        ),
      ],
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
