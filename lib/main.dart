import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';
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
    return MaterialApp(
      title: 'Da Grande',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      home: const _LoadingGate(),
    );
  }
}

/// Mostra uno spinner finche AppState non ha caricato i dati salvati,
/// poi lascia spazio alla mappa del percorso.
class _LoadingGate extends StatelessWidget {
  const _LoadingGate();

  @override
  Widget build(BuildContext context) {
    final loaded = context.select<AppState, bool>((s) => s.loaded);
    if (!loaded) {
      return const Scaffold(
        backgroundColor: AppColors.ink,
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.amber),
          ),
        ),
      );
    }
    return const HomeScreen();
  }
}
