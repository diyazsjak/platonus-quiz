import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/attempt_bar_type/attempt_bar_type_cubit.dart';
import 'bloc/file_quiz/file_quiz_bloc.dart';
import 'bloc/ongoing_quiz/ongoing_quiz_bloc.dart';
import 'bloc/quizes_list/quizes_list_bloc.dart';
import 'core/constants.dart';
import 'screens/home_screen.dart';
import 'screens/quiz_screen.dart';
import 'services/settings_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SettingsService().init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Constants.homeRoute,
      routes: {
        Constants.homeRoute: (context) {
          return BlocProvider(
            create: (context) => AttemptBarTypeCubit()..getType(),
            child: const HomeScreen(),
          );
        },
        Constants.quizRoute: (context) => const QuizScreen(),
      },
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => OngoingQuizBloc()),
            BlocProvider(
              create: (context) => QuizesListBloc()..add(QuizesListStarted()),
            ),
            BlocProvider(create: (context) => FileQuizBloc()),
          ],
          child: child!,
        );
      },
    );
  }
}
