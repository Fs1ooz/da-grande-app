import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final state = context.read<AppState>();
    final accent = AppColors.stageColors[2];

    return SectionScaffold(
      title: Stage.reflected.title,
      subtitle: Stage.reflected.subtitle,
      accent: accent,
      children: [
        InfoCard(
          accent: accent,
          icon: Icons.record_voice_over_outlined,
          text:
              'L\'identita riflessa e l\'immagine che ti arriva da fuori: le etichette '
              'che gli altri ti mettono addosso. A volte ti danno forza, a volte ti '
              'limitano. Scrivi cosa ti hanno detto, chiediti se ti rispecchia '
              'davvero, poi riscrivilo come lo senti tu.',
        ),
        const SizedBox(height: 20),
        for (int i = 0; i < state.data.reflected.length; i++)
          _PhraseCard(
            number: i + 1,
            accent: accent,
            mirrorOptions: _mirrorOptions,
            phrase: state.data.reflected[i],
            onChanged: () => setState(() => state.save()),
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
