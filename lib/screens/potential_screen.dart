import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/content.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../widgets/common.dart';
import '../widgets/radar_wheel.dart';

class PotentialScreen extends StatefulWidget {
  const PotentialScreen({super.key});

  @override
  State<PotentialScreen> createState() => _PotentialScreenState();
}

class _PotentialScreenState extends State<PotentialScreen> {
  static const _scaleLabels = ['0', '1', '2', '3'];

  @override
  Widget build(BuildContext context) {
    final state = context.read<AppState>();
    final accent = AppColors.stageColors[3];

    return SectionScaffold(
      title: Stage.potential.title,
      subtitle: Stage.potential.subtitle,
      accent: accent,
      children: [
        InfoCard(
          accent: accent,
          icon: Icons.bolt_outlined,
          text:
              'Il potenziale e un patrimonio interiore fatto di tre parti: i talenti '
              '(le tue predisposizioni naturali), le risorse interiori (la tua benzina '
              'emotiva) e le capacita allenate (cio che costruisci con la pratica).',
        ),
        const SizedBox(height: 20),
        _ListBox(
          title: 'TALENTI',
          hint: 'Cose che ti riescono con naturalezza',
          icon: Icons.star_rounded,
          color: AppColors.amber,
          items: state.data.talenti,
          onChanged: () { setState(() {}); state.save(); },
        ),
        const SizedBox(height: 14),
        _ListBox(
          title: 'RISORSE',
          hint: 'La tua benzina psicologica ed emotiva',
          icon: Icons.favorite_rounded,
          color: AppColors.coral,
          items: state.data.risorse,
          onChanged: () { setState(() {}); state.save(); },
        ),
        const SizedBox(height: 14),
        _ListBox(
          title: 'CAPACITA',
          hint: 'Abilita che hai allenato e vuoi allenare',
          icon: Icons.fitness_center_rounded,
          color: AppColors.cyan,
          items: state.data.capacita,
          onChanged: () { setState(() {}); state.save(); },
        ),
        const SizedBox(height: 28),
        const Text('Test delle Intelligenze Multiple',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
        const SizedBox(height: 4),
        const Text(
          'Teoria di Howard Gardner. Per ogni frase: 0 per niente, 1 poco, '
          '2 abbastanza, 3 molto.',
          style: TextStyle(fontSize: 13, color: AppColors.muted),
        ),
        const SizedBox(height: 16),
        for (int t = 0; t < intelligences.length; t++)
          _IntelCard(
            index: t,
            scaleLabels: _scaleLabels,
            accent: accent,
            onChanged: () { setState(() {}); state.save(); },
          ),
        const SizedBox(height: 12),
        SoftCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text('La tua Ruota delle Intelligenze',
                  style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              RadarWheel(
                labels: intelligences.map((e) => e.key).toList(),
                values: state.intelScores(),
                maxValue: 15,
                color: accent,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ListBox extends StatefulWidget {
  final String title;
  final String hint;
  final IconData icon;
  final Color color;
  final List<String> items;
  final VoidCallback onChanged;

  const _ListBox({
    required this.title,
    required this.hint,
    required this.icon,
    required this.color,
    required this.items,
    required this.onChanged,
  });

  @override
  State<_ListBox> createState() => _ListBoxState();
}

class _ListBoxState extends State<_ListBox> {
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers =
        widget.items.map((t) => TextEditingController(text: t)).toList();
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _add() {
    setState(() {
      widget.items.add('');
      _controllers.add(TextEditingController());
    });
    widget.onChanged();
  }

  void _remove(int i) {
    setState(() {
      widget.items.removeAt(i);
      _controllers.removeAt(i).dispose();
    });
    widget.onChanged();
  }

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(widget.icon, color: widget.color, size: 22),
              const SizedBox(width: 8),
              Text(widget.title,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: widget.color,
                      letterSpacing: 0.5)),
            ],
          ),
          const SizedBox(height: 4),
          Text(widget.hint,
              style:
                  const TextStyle(fontSize: 12.5, color: AppColors.muted)),
          const SizedBox(height: 12),
          for (int i = 0; i < widget.items.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controllers[i],
                      textCapitalization: TextCapitalization.sentences,
                      decoration:
                          InputDecoration(hintText: 'Voce ${i + 1}'),
                      onChanged: (v) {
                        widget.items[i] = v;
                        widget.onChanged();
                      },
                    ),
                  ),
                  if (widget.items.length > 1)
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline,
                          color: AppColors.muted),
                      onPressed: () => _remove(i),
                    ),
                ],
              ),
            ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: _add,
              icon: Icon(Icons.add, size: 18, color: widget.color),
              label: Text('Aggiungi',
                  style: TextStyle(
                      color: widget.color, fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }
}

class _IntelCard extends StatelessWidget {
  final int index;
  final List<String> scaleLabels;
  final Color accent;
  final VoidCallback onChanged;

  const _IntelCard({
    required this.index,
    required this.scaleLabels,
    required this.accent,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.read<AppState>();
    final entry = intelligences[index];
    final items = entry.value;
    final score = state.intelScores()[index];

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SoftCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text('Intelligenza ${entry.key}',
                      style: const TextStyle(
                          fontSize: 15.5, fontWeight: FontWeight.w800)),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text('$score/15',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: accent)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            for (int q = 0; q < items.length; q++) ...[
              Text(items[q],
                  style: const TextStyle(fontSize: 13.5, height: 1.3)),
              const SizedBox(height: 8),
              ChoiceRow(
                options: scaleLabels,
                selected: state.data.intel[index][q] < 0
                    ? null
                    : state.data.intel[index][q],
                accent: accent,
                onSelect: (v) {
                  state.data.intel[index][q] = v;
                  onChanged();
                },
              ),
              if (q < items.length - 1) const SizedBox(height: 14),
            ],
          ],
        ),
      ),
    );
  }
}
