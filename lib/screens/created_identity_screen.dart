import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../data/content.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../widgets/common.dart';

class CreatedIdentityScreen extends StatefulWidget {
  const CreatedIdentityScreen({super.key});

  @override
  State<CreatedIdentityScreen> createState() => _CreatedIdentityScreenState();
}

class _CreatedIdentityScreenState extends State<CreatedIdentityScreen> {
  bool _introRead = false;
  late final TextEditingController _declCtrl;

  @override
  void initState() {
    super.initState();
    final state = context.read<AppState>();
    _declCtrl = TextEditingController(text: state.data.declaration);
  }

  @override
  void dispose() {
    _declCtrl.dispose();
    super.dispose();
  }

  Future<void> _generate() async {
    final state = context.read<AppState>();
    final text = await state.generateDeclaration();
    if (!mounted) return;
    setState(() => _declCtrl.text = text);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Proclama generato dalle tue risposte')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.stageColors[7];

    if (!_introRead) {
      return IntroCard(
        title: Stage.created.title,
        text: sectionIntros['created']!,
        accentColor: accent,
        onStart: () => setState(() => _introRead = true),
      );
    }

    final state = context.read<AppState>();

    return SectionScaffold(
      title: Stage.created.title,
      subtitle: Stage.created.subtitle,
      accent: accent,
      children: [
        const FieldLabel('Mi chiamo'),
        JournalField(
          initial: state.data.name,
          hint: 'Il tuo nome',
          onChanged: (v) {
            state.data.name = v;
            state.save();
          },
        ),
        const SizedBox(height: 20),
        const Text('Chi voglio essere da oggi',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
        const SizedBox(height: 12),
        for (int i = 0; i < presentationQuestions.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: SoftCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${i + 1}. ${presentationQuestions[i]}',
                      style: const TextStyle(
                          fontSize: 14, height: 1.35,
                          fontWeight: FontWeight.w700)),
                  const SizedBox(height: 10),
                  JournalField(
                    initial: state.data.presentation[i] ?? '',
                    hint: 'La tua risposta',
                    maxLines: 2,
                    onChanged: (v) {
                      state.data.presentation[i] = v;
                      state.save();
                    },
                  ),
                ],
              ),
            ),
          ),
        const SizedBox(height: 8),
        FilledButton.icon(
          onPressed: _generate,
          icon: const Icon(Icons.bolt),
          label: const Text('Genera il mio proclama'),
        ),
        const SizedBox(height: 20),
        const Text('Il mio proclama di vita',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
        const SizedBox(height: 6),
        const Text(
          'Puoi modificarlo liberamente: e la tua dichiarazione, unica e irripetibile.',
          style: TextStyle(fontSize: 12.5, color: AppColors.muted),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [accent.withValues(alpha: 0.10), AppColors.cyan.withValues(alpha: 0.10)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: accent.withValues(alpha: 0.25)),
          ),
          padding: const EdgeInsets.all(8),
          child: TextField(
            controller: _declCtrl,
            maxLines: null,
            minLines: 8,
            style: const TextStyle(fontSize: 14.5, height: 1.5),
            decoration: const InputDecoration(
              filled: false,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText:
                  'Premi "Genera il mio proclama" per comporlo dalle tue risposte.',
            ),
            onChanged: (v) {
              state.data.declaration = v;
              state.save();
            },
          ),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: _declCtrl.text));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Proclama copiato')),
            );
          },
          icon: const Icon(Icons.copy_all_outlined),
          label: const Text('Copia il proclama'),
        ),
      ],
    );
  }
}
