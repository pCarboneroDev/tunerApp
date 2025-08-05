import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';
import 'package:tuner_app/presentation/navigation_bar/bottom_navbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeStr = await rootBundle.loadString('assets/themes/tuner_dark_theme.json');
  // 🔹 2. Decodificar el string como JSON
  final themeJson = jsonDecode(themeStr);

  // 🔹 3. Convertir el JSON a ThemeData
  final theme = ThemeDecoder.decodeThemeData(themeJson);

  runApp(MyApp(theme!)); //Arguments of a constant creation must be constant expressions.
}

class MyApp extends StatelessWidget {
  final ThemeData theme;

  const MyApp(this.theme, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme,
      home: BottomNavbarPage(),
    );
  }
}

