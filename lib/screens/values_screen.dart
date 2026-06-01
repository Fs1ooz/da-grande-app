import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/journey_data.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../widgets/common.dart';

class ValuesScreen extends StatefulWidget {
  const ValuesScreen({super.key});

  @override
  State<ValuesScreen> createState() => _ValuesScreenState();
}

class _ValuesScreenState extends State<ValuesScreen> {
  @override
  Widget build(BuildContext context) {
    final state = context.read<AppState>();
    final accent = AppColors.stageColors[5];

    return SectionScaffold(
      title: Stage.valori.title,
      subtitle: Stage.valori.subtitle,
      accent: accent,
      children: [
        InfoCard(
          accent: accent,
          icon: Icons.explore_outlined,
          text:
              'I valori sono il GPS della tua vita: se sono chiari sai dove andare. '
              'Avere chiari i valori pero non basta: servono i criteri, cioe le regole '
              'personali che ti dicono quando quel valore e davvero presente nella tua vita.',
        ),
        const SizedBox(height: 12),
        const InfoCard(
          accent: AppColors.muted,
          icon: Icons.info_outline,
          text:
              'Valori mezzo: sono strumenti per raggiungere qualcosa (es. lo studio, '
              'i soldi). Valori fine: sono la destinazione, cio che vuoi davvero vivere '
              '(es. liberta, conoscenza, gioia).',
        ),
        const SizedBox(height: 20),
        for (int i = 0; i < state.data.values.length; i++)
          _ValueCard(
            number: i + 1,
            accent: accent,
            entry: state.data.values[i],
            onChanged: () => setState(() => state.save()),
          ),
      ],
    );
  }
}

class _ValueCard extends StatelessWidget {
  final int number;
  final Color accent;
  final ValueEntry entry;
  final VoidCallback onChanged;

  const _ValueCard({
    required this.number,
    required this.accent,
    required this.entry,
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
            Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('$number',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w800)),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text('Il mio valore',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            JournalField(
              initial: entry.value,
              hint: 'Es. Liberta, Curiosita, Affermazione',
              onChanged: (v) {
                entry.value = v;
                onChanged();
              },
            ),
            const SizedBox(height: 12),
            const FieldLabel('Lo vivo ogni volta che...'),
            for (int c = 0; c < entry.criteria.length; c++)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 14, right: 8),
                      child: Icon(Icons.chevron_right, size: 18, color: accent),
                    ),
                    Expanded(
                      child: JournalField(
                        initial: entry.criteria[c],
                        hint: 'Criterio ${c + 1}',
                        onChanged: (v) {
                          entry.criteria[c] = v;
                          onChanged();
                        },
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
