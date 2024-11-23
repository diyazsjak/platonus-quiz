import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/quiz/quiz_bloc.dart';
import 'bloc/quizes/quizes_list_bloc.dart';
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
        Constants.homeRoute: (context) => const HomeScreen(),
        Constants.quizRoute: (context) => const QuizScreen(),
      },
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => QuizBloc()),
            BlocProvider(
              create: (context) => QuizesListBloc()..add(QuizesStarted()),
            ),
          ],
          child: child!,
        );
      },
    );
  }
}
