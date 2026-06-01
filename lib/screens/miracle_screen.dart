import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/content.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../widgets/common.dart';

class MiracleScreen extends StatefulWidget {
  const MiracleScreen({super.key});

  @override
  State<MiracleScreen> createState() => _MiracleScreenState();
}

class _MiracleScreenState extends State<MiracleScreen> {
  bool _introRead = false;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.stageColors[6];

    if (!_introRead) {
      return IntroCard(
        title: Stage.miracle.title,
        text: sectionIntros['miracle']!,
        accentColor: accent,
        onStart: () => setState(() => _introRead = true),
      );
    }

    final state = context.read<AppState>();

    return SectionScaffold(
      title: Stage.miracle.title,
      subtitle: Stage.miracle.subtitle,
      accent: accent,
      children: [
        for (int i = 0; i < miracleQuestions.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: SoftCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${i + 1}. ${miracleQuestions[i]}',
                      style: const TextStyle(
                          fontSize: 14.5,
                          height: 1.35,
                          fontWeight: FontWeight.w700)),
                  const SizedBox(height: 12),
                  JournalField(
                    initial: state.data.miracle[i],
                    hint: 'Scrivi cio che senti',
                    maxLines: 4,
                    onChanged: (v) {
                      state.data.miracle[i] = v;
                      state.save();
                    },
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
