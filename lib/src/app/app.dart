import 'package:flutter/material.dart';
import 'package:ibdex/src/features/auth/presentation/auth_gate.dart';
import 'package:ibdex/src/shared/utils/theme_controller.dart';

/// Le point d'entrée principal des widgets de l'application.
/// Définit le thème global et la navigation racine.
class IbdexApp extends StatelessWidget {
  const IbdexApp({super.key});

  @override
    Widget build(BuildContext context) {
      return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (context, currentMode, child){
          return MaterialApp(
            title: 'IBDEX',
            themeMode: currentMode,
            theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          darkTheme: ThemeData.dark(useMaterial3: true),
          home: const AuthGate(),
        );
      },
    );
  }
}
