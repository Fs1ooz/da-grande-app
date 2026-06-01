import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';
import 'screens/welcome_screen.dart';
import 'state/app_state.dart';
import 'theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState()..load(),
      child: const DaGrandeApp(),
    ),
  );
}

class DaGrandeApp extends StatelessWidget {
  const DaGrandeApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.select<AppState, bool>((s) => s.isDark);
    return MaterialApp(
      title: 'Da Grande',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      darkTheme: buildDarkTheme(),
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      home: const _LoadingGate(),
    );
  }
}

/// Mostra uno spinner finche AppState non ha caricato i dati salvati,
/// poi mostra WelcomeScreen al primo avvio, altrimenti HomeScreen.
class _LoadingGate extends StatelessWidget {
  const _LoadingGate();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    if (!state.loaded) {
      return const Scaffold(
        backgroundColor: AppColors.ink,
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.amber),
          ),
        ),
      );
    }
    if (!state.welcomeSeen) return const WelcomeScreen();
    return const HomeScreen();
  }
}
