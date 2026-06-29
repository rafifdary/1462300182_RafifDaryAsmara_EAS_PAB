import 'package:flutter/material.dart';
import 'utils/app_routes.dart';
import 'utils/app_theme.dart';

class QuizLearnApp extends StatelessWidget {
  const QuizLearnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuizLearn',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
    );
  }
}
