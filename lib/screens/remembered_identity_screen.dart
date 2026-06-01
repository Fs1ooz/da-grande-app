import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/journey_data.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../widgets/common.dart';

class RememberedIdentityScreen extends StatefulWidget {
  const RememberedIdentityScreen({super.key});

  @override
  State<RememberedIdentityScreen> createState() =>
      _RememberedIdentityScreenState();
}

class _RememberedIdentityScreenState extends State<RememberedIdentityScreen> {
  @override
  Widget build(BuildContext context) {
    final state = context.read<AppState>();
    final accent = AppColors.stageColors[1];

    return SectionScaffold(
      title: Stage.remembered.title,
      subtitle: Stage.remembered.subtitle,
      accent: accent,
      children: [
        InfoCard(
          accent: accent,
          icon: Icons.history_edu_outlined,
          text:
              'L\'identita ricordata nasce da episodi che ti porti ancora addosso. '
              'A volte sono vittorie che ti hanno dato forza, altre ferite che '
              'sembrano averti definito. Per ognuno scegli un\'etichetta e decidi '
              'se tenerla con te o lasciarla andare.',
        ),
        const SizedBox(height: 24),
        const _GroupHeader(
          color: AppColors.mint,
          icon: Icons.trending_up,
          title: 'Episodi che ti potenziano',
          subtitle: 'Momenti che ti hanno fatto crescere',
        ),
        const SizedBox(height: 12),
        for (int i = 0; i < state.data.empowering.length; i++)
          _EpisodeCard(
            number: i + 1,
            episode: state.data.empowering[i],
            accent: AppColors.mint,
            onChanged: () => setState(() => state.save()),
          ),
        const SizedBox(height: 24),
        const _GroupHeader(
          color: AppColors.coral,
          icon: Icons.trending_down,
          title: 'Episodi che ti depotenziano',
          subtitle: 'Ricordi che oggi ti frenano ancora',
        ),
        const SizedBox(height: 12),
        for (int i = 0; i < state.data.disempowering.length; i++)
          _EpisodeCard(
            number: i + 1,
            episode: state.data.disempowering[i],
            accent: AppColors.coral,
            onChanged: () => setState(() => state.save()),
          ),
      ],
    );
  }
}

class _GroupHeader extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final String subtitle;

  const _GroupHeader({
    required this.color,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w800)),
              Text(subtitle,
                  style:
                      const TextStyle(fontSize: 12.5, color: AppColors.muted)),
            ],
          ),
        ),
      ],
    );
  }
}

class _EpisodeCard extends StatelessWidget {
  final int number;
  final EpisodeEntry episode;
  final Color accent;
  final VoidCallback onChanged;

  const _EpisodeCard({
    required this.number,
    required this.episode,
    required this.accent,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SoftCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Episodio $number',
                style: TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w800, color: accent)),
            const SizedBox(height: 8),
            JournalField(
              initial: episode.text,
              hint: 'Cosa e successo?',
              maxLines: 2,
              onChanged: (v) {
                episode.text = v;
                onChanged();
              },
            ),
            const SizedBox(height: 10),
            JournalField(
              initial: episode.label,
              hint: 'Etichetta (es. Coraggioso, Autonomo, Non all\'altezza)',
              onChanged: (v) {
                episode.label = v;
                onChanged();
              },
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _KeepButton(
                    label: 'La tengo',
                    icon: Icons.check_circle_outline,
                    selected: episode.keep,
                    color: AppColors.mint,
                    onTap: () {
                      episode.keep = true;
                      onChanged();
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _KeepButton(
                    label: 'La lascio andare',
                    icon: Icons.cancel_outlined,
                    selected: !episode.keep,
                    color: AppColors.coral,
                    onTap: () {
                      episode.keep = false;
                      onChanged();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _KeepButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const _KeepButton({
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
        padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 8),
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
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: selected ? color : AppColors.muted,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
