import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/content.dart';
import '../models/journey_data.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../widgets/common.dart';

class ReflectedIdentityScreen extends StatefulWidget {
  const ReflectedIdentityScreen({super.key});

  @override
  State<ReflectedIdentityScreen> createState() =>
      _ReflectedIdentityScreenState();
}

class _ReflectedIdentityScreenState extends State<ReflectedIdentityScreen> {
  static const _mirrorOptions = ['No', 'In parte', 'Si'];
  bool _introRead = false;

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.stageColors[2];

    if (!_introRead) {
      return IntroCard(
        title: Stage.reflected.title,
        text: sectionIntros['reflected']!,
        accentColor: accent,
        onStart: () => setState(() => _introRead = true),
      );
    }

    final state = context.read<AppState>();

    return SectionScaffold(
      title: Stage.reflected.title,
      subtitle: Stage.reflected.subtitle,
      accent: accent,
      children: [
        for (int i = 0; i < state.data.reflected.length; i++)
          _PhraseCard(
            number: i + 1,
            accent: accent,
            mirrorOptions: _mirrorOptions,
            phrase: state.data.reflected[i],
            onChanged: () { setState(() {}); state.save(); },
          ),
      ],
    );
  }
}

class _PhraseCard extends StatelessWidget {
  final int number;
  final Color accent;
  final List<String> mirrorOptions;
  final ReflectedPhrase phrase;
  final VoidCallback onChanged;

  const _PhraseCard({
    required this.number,
    required this.accent,
    required this.mirrorOptions,
    required this.phrase,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: SoftCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Frase $number',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: accent)),
            const SizedBox(height: 8),
            JournalField(
              initial: phrase.said,
              hint: 'Cosa ti hanno detto di te',
              maxLines: 2,
              onChanged: (v) {
                phrase.said = v;
                onChanged();
              },
            ),
            const SizedBox(height: 12),
            const FieldLabel('Mi rispecchia davvero?'),
            ChoiceRow(
              options: mirrorOptions,
              selected: phrase.mirrors,
              accent: accent,
              onSelect: (v) {
                phrase.mirrors = v;
                onChanged();
              },
            ),
            const SizedBox(height: 12),
            const FieldLabel('La riscrivo cosi come la sento io'),
            JournalField(
              initial: phrase.rewritten,
              hint: 'La tua versione, piu vera',
              maxLines: 2,
              onChanged: (v) {
                phrase.rewritten = v;
                onChanged();
              },
            ),
          ],
        ),
      ),
    );
  }
}
