import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import '../theme.dart';
import 'created_identity_screen.dart';
import 'miracle_screen.dart';
import 'potential_screen.dart';
import 'programmed_identity_screen.dart';
import 'reflected_identity_screen.dart';
import 'remembered_identity_screen.dart';
import 'values_screen.dart';
import 'wheel_of_life_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _screenFor(Stage s) {
    switch (s) {
      case Stage.wheel:
        return const WheelOfLifeScreen();
      case Stage.remembered:
        return const RememberedIdentityScreen();
      case Stage.reflected:
        return const ReflectedIdentityScreen();
      case Stage.potential:
        return const PotentialScreen();
      case Stage.programmed:
        return const ProgrammedIdentityScreen();
      case Stage.valori:
        return const ValuesScreen();
      case Stage.miracle:
        return const MiracleScreen();
      case Stage.created:
        return const CreatedIdentityScreen();
    }
  }

  IconData _iconFor(Stage s) {
    switch (s) {
      case Stage.wheel:
        return Icons.donut_large;
      case Stage.remembered:
        return Icons.history_edu;
      case Stage.reflected:
        return Icons.record_voice_over;
      case Stage.potential:
        return Icons.bolt;
      case Stage.programmed:
        return Icons.campaign;
      case Stage.valori:
        return Icons.explore;
      case Stage.miracle:
        return Icons.auto_awesome;
      case Stage.created:
        return Icons.workspace_premium;
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _Header(progress: state.progress)),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 40),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final stage = StageList.all[index];
                    return _StageTile(
                      stage: stage,
                      number: index + 1,
                      icon: _iconFor(stage),
                      color: AppColors.stageColors[index],
                      done: state.isComplete(stage),
                      isLast: index == StageList.all.length - 1,
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (_) => _screenFor(stage)))
                            .then((_) => state.notify());
                      },
                    );
                  },
                  childCount: StageList.all.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final double progress;
  const _Header({required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.ink, AppColors.primary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Da Grande',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5)),
              Builder(
                builder: (ctx) => IconButton(
                  icon: const Icon(Icons.more_horiz, color: Colors.white),
                  onPressed: () => _showMenu(ctx),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          const Text(
            'Un viaggio dentro di te: dalla ruota della vita\nfino a chi scegli di essere da oggi.',
            style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.4),
          ),
          const SizedBox(height: 22),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: Colors.white24,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.amber),
            ),
          ),
          const SizedBox(height: 8),
          Text('${(progress * 100).round()}% del percorso completato',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              ListTile(
                leading: const Icon(Icons.refresh, color: AppColors.coral),
                title: const Text('Ricomincia da capo'),
                subtitle: const Text('Cancella tutte le risposte'),
                onTap: () async {
                  Navigator.pop(ctx);
                  final ok = await showDialog<bool>(
                    context: context,
                    builder: (d) => AlertDialog(
                      title: const Text('Sei sicuro?'),
                      content: const Text(
                          'Tutte le tue risposte verranno cancellate. '
                          'Questa azione non puo essere annullata.'),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(d, false),
                            child: const Text('Annulla')),
                        TextButton(
                            onPressed: () => Navigator.pop(d, true),
                            child: const Text('Cancella',
                                style: TextStyle(color: AppColors.coral))),
                      ],
                    ),
                  );
                  if (ok == true && context.mounted) {
                    await context.read<AppState>().reset();
                  }
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}

class _StageTile extends StatelessWidget {
  final Stage stage;
  final int number;
  final IconData icon;
  final Color color;
  final bool done;
  final bool isLast;
  final VoidCallback onTap;

  const _StageTile({
    required this.stage,
    required this.number,
    required this.icon,
    required this.color,
    required this.done,
    required this.isLast,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Colonna del "cammino": pallino + linea.
          Column(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: done ? color : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: color, width: 2),
                ),
                child: Icon(icon, size: 22, color: done ? Colors.white : color),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2.5,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: color.withValues(alpha: 0.30),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
              child: GestureDetector(
                onTap: onTap,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xFFE8ECF5)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('Tappa $number',
                                    style: TextStyle(
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w800,
                                        color: color)),
                                if (done) ...[
                                  const SizedBox(width: 6),
                                  const Icon(Icons.check_circle,
                                      size: 14, color: AppColors.mint),
                                ],
                              ],
                            ),
                            const SizedBox(height: 3),
                            Text(stage.title,
                                style: const TextStyle(
                                    fontSize: 16.5,
                                    fontWeight: FontWeight.w800,
                                    height: 1.15)),
                            const SizedBox(height: 2),
                            Text(stage.subtitle,
                                style: const TextStyle(
                                    fontSize: 12.5, color: AppColors.muted)),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: AppColors.muted),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
