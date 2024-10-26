import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/quiz_bloc.dart';
import 'core/constants.dart';
import 'screens/home_screen.dart';
import 'screens/quiz_screen.dart';

void main() {
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
        return BlocProvider(
          create: (context) => QuizBloc(),
          child: child,
        );
      },
    );
  }
}
