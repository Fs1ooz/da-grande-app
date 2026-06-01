import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/journey_data.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../widgets/common.dart';

class ProgrammedIdentityScreen extends StatefulWidget {
  const ProgrammedIdentityScreen({super.key});

  @override
  State<ProgrammedIdentityScreen> createState() =>
      _ProgrammedIdentityScreenState();
}

class _ProgrammedIdentityScreenState extends State<ProgrammedIdentityScreen> {
  @override
  Widget build(BuildContext context) {
    final state = context.read<AppState>();
    final accent = AppColors.stageColors[4];

    return SectionScaffold(
      title: Stage.programmed.title,
      subtitle: Stage.programmed.subtitle,
      accent: accent,
      children: [
        InfoCard(
          accent: accent,
          icon: Icons.campaign_outlined,
          text:
              'A volte gli altri parlano del tuo futuro come se fosse gia scritto. '
              'Ma il futuro non e una profezia: e una scelta. Scrivi le frasi che hai '
              'sentito su cosa diventerai, segna se ti motivano o ti limitano, poi '
              'riscrivile partendo da "Io voglio...".',
        ),
        const SizedBox(height: 20),
        for (int i = 0; i < state.data.programmed.length; i++)
          _ProgCard(
            number: i + 1,
            accent: accent,
            phrase: state.data.programmed[i],
            onChanged: () => setState(() => state.save()),
          ),
      ],
    );
  }
}

class _ProgCard extends StatelessWidget {
  final int number;
  final Color accent;
  final ProgrammedPhrase phrase;
  final VoidCallback onChanged;

  const _ProgCard({
    required this.number,
    required this.accent,
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
            Text('Frase degli altri $number',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: accent)),
            const SizedBox(height: 8),
            JournalField(
              initial: phrase.said,
              hint: 'Es. "Diventerai un ingegnere", "Dovresti iscriverti a..."',
              maxLines: 2,
              onChanged: (v) {
                phrase.said = v;
                onChanged();
              },
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _Flag(
                    label: 'Motivante',
                    icon: Icons.check,
                    selected: phrase.motivating,
                    color: AppColors.mint,
                    onTap: () {
                      phrase.motivating = true;
                      onChanged();
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _Flag(
                    label: 'Limitante',
                    icon: Icons.close,
                    selected: !phrase.motivating,
                    color: AppColors.coral,
                    onTap: () {
                      phrase.motivating = false;
                      onChanged();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const FieldLabel('Io voglio...'),
            JournalField(
              initial: phrase.iWant,
              hint: 'Riscrivila con parole tue',
              maxLines: 2,
              onChanged: (v) {
                phrase.iWant = v;
                onChanged();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Flag extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const _Flag({
    required this.label,
    required this.icon,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 11),
        decoration: BoxDecoration(
          color: selected ? color.withValues(alpha: 0.14) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: selected ? color : const Color(0xFFE1E6F0),
              width: selected ? 1.6 : 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: selected ? color : AppColors.muted),
            const SizedBox(width: 6),
            Text(label,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: selected ? color : AppColors.muted)),
          ],
        ),
      ),
    );
  }
}
