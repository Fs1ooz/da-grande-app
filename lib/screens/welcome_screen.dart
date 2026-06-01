import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/content.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../widgets/common.dart';
import 'home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroCard(
      title: 'Benvenuto in Da Grande',
      text: sectionIntros['welcome']!,
      accentColor: AppColors.primary,
      ctaLabel: 'Inizia il viaggio',
      onStart: () async {
        await context.read<AppState>().markWelcomeSeen();
        if (!context.mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      },
    );
  }
}
