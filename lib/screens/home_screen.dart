import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/quiz/quiz_bloc.dart';
import '../core/constants.dart';
import '../util/loading.dart';
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
      context.read<QuizBloc>().add(QuizSelected(filePath: filePath));
    }
  }

  void _showSettingsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return const Settings();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuizBloc, QuizState>(
      listener: (BuildContext context, state) async {
        if (state is QuizLoadInProgress) {
          Loading.show(context);
        } else if (state is QuizLoadFailure) {
          Loading.remove(context);
          showSnackbar(context, 'Wrong quiz format');
        } else if (state is QuizLoadSuccess) {
          Loading.remove(context);
          Navigator.of(context).pushNamed(Constants.quizRoute);
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
