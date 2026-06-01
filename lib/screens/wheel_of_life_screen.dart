import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/content.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../widgets/common.dart';
import '../widgets/radar_wheel.dart';

class WheelOfLifeScreen extends StatefulWidget {
  const WheelOfLifeScreen({super.key});

  @override
  State<WheelOfLifeScreen> createState() => _WheelOfLifeScreenState();
}

class _WheelOfLifeScreenState extends State<WheelOfLifeScreen> {
  static const _options = ['No', 'In parte', 'Si'];

  @override
  Widget build(BuildContext context) {
    final state = context.read<AppState>();
    final accent = AppColors.stageColors[0];

    return SectionScaffold(
      title: Stage.wheel.title,
      subtitle: 'Per ogni frase: No, In parte o Si',
      accent: accent,
      children: [
        const InfoCard(
          accent: AppColors.primary,
          icon: Icons.explore_outlined,
          text:
              'La Ruota della Vita e come uno specchio: mostra in un colpo d\'occhio '
              'quanto equilibrio c\'e tra le aree importanti per te. Piu la ruota e '
              'armonica, piu il tuo viaggio scorre fluido.',
        ),
        const SizedBox(height: 20),
        for (int area = 0; area < wheelAreas.length; area++)
          _AreaCard(
            index: area,
            accent: accent,
            options: _options,
            onChanged: () { setState(() {}); state.save(); },
          ),
        const SizedBox(height: 8),
        const _ResultCard(),
        const SizedBox(height: 16),
        const FieldLabel('Osservazioni personali: cosa hai scoperto?'),
        JournalField(
          initial: state.data.wheelObservations,
          hint: 'Dove stai bene? Dove vuoi crescere?',
          maxLines: 4,
          onChanged: (v) {
            state.data.wheelObservations = v;
            state.save();
          },
        ),
      ],
    );
  }
}

class _AreaCard extends StatelessWidget {
  final int index;
  final Color accent;
  final List<String> options;
  final VoidCallback onChanged;

  const _AreaCard({
    required this.index,
    required this.accent,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.read<AppState>();
    final entry = wheelAreas[index];
    final questions = entry.value;
    final score = state.wheelScores()[index];

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: SoftCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${index + 1}. ${entry.key}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '$score/10',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: accent,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            for (int q = 0; q < questions.length; q++) ...[
              Text(
                questions[q],
                style: const TextStyle(fontSize: 14, height: 1.35),
              ),
              const SizedBox(height: 8),
              ChoiceRow(
                options: options,
                selected: state.data.wheel[index][q] < 0
                    ? null
                    : state.data.wheel[index][q],
                accent: accent,
                onSelect: (v) {
                  state.data.wheel[index][q] = v;
                  onChanged();
                },
              ),
              if (q < questions.length - 1) const SizedBox(height: 14),
            ],
          ],
        ),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return SoftCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'La tua ruota',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          RadarWheel(
            labels: wheelShortLabels,
            values: state.wheelScores(),
            maxValue: 10,
            color: AppColors.stageColors[0],
          ),
        ],
      ),
    );
  }
}
