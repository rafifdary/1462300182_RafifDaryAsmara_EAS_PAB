import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/splash_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String splash = "/";

  static const String login = "/login";

  static const String register = "/register";

  static const String home = "/home";

  static Map<String, WidgetBuilder> routes = {
    splash: (_) => const SplashScreen(),

    login: (_) => const LoginScreen(),

    register: (_) => const RegisterScreen(),

    home: (_) => const HomeScreen(),
  };
}