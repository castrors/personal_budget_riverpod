import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_budget/routes.dart';

void main() async {
  runApp(const ProviderScope(child: PersonalBudgetApp()));
}

class PersonalBudgetApp extends StatelessWidget {
  const PersonalBudgetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Personal Budget',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.teal,
          secondary: Colors.pinkAccent, // Your accent color
        ),
      ),
      routerConfig: router,
    );
  }
}
