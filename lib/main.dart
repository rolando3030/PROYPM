import 'package:flutter/material.dart';

import 'pages/home/home_page.dart';
import 'pages/sign_in/sign_in_page.dart';
import 'pages/sign_up/sign_up_page.dart';
import 'pages/reset_password/reset_password_page.dart';
import 'pages/confirmar_password/confirmar_password_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      colorSchemeSeed: const Color(0xFF4B4CC1), // <-- 'const' en minúsculas
      useMaterial3: true,
    );

    return MaterialApp(
      title: 'Cine Star',
      debugShowCheckedModeBanner: false,
      theme: theme,
      initialRoute: '/sign-in',
      routes: {
        '/home': (_) =>
            const HomePage(), // déjalo const si tu HomePage tiene constructor const
        '/sign-in': (_) =>
            SignInPage(), // NO const (tu SignInPage es Stateful/usa controladores)
        '/sign-up': (_) => SignUpPage(), // NO const (si no es const)
        '/reset-password': (_) =>
            ResetPasswordPage(), // NO const (si no es const)
        '/confirmar-password': (_) =>
            const ConfirmarPasswordPage(), // const si tu page es const
      },
    );
  }
}
