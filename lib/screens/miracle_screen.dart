import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/content.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../widgets/common.dart';

class MiracleScreen extends StatelessWidget {
  const MiracleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<AppState>();
    final accent = AppColors.stageColors[6];

    return SectionScaffold(
      title: Stage.miracle.title,
      subtitle: Stage.miracle.subtitle,
      accent: accent,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.cyan],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('1 su 300 milioni',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w900)),
              SizedBox(height: 10),
              Text(
                'Le probabilita che tu fossi qui sarebbero praticamente nulle. '
                'Eppure esisti. Non e un caso: e il segno che la tua vita ha un '
                'valore che supera ogni statistica. Prima ancora di scoprire chi '
                'sei e cosa sai fare, ricordati che esserci e gia straordinario.',
                style: TextStyle(
                    color: Colors.white, fontSize: 14, height: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
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
