import 'package:flutter/material.dart';

import '../theme.dart';

/// Scaffold standard per una sezione del percorso.
class SectionScaffold extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Color accent;
  final List<Widget> children;
  final Widget? bottom;

  const SectionScaffold({
    super.key,
    required this.title,
    this.subtitle,
    required this.accent,
    required this.children,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
          children: [
            Row(
              children: [
                Container(
                  width: 6,
                  height: 38,
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          height: 1.1,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          subtitle!,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.muted,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ...children,
            if (bottom != null) ...[
              const SizedBox(height: 24),
              bottom!,
            ],
          ],
        ),
      ),
    );
  }
}

/// Box informativo con sfondo colorato tenue (per i testi del fascicolo).
class InfoCard extends StatelessWidget {
  final String text;
  final Color accent;
  final IconData icon;

  const InfoCard({
    super.key,
    required this.text,
    required this.accent,
    this.icon = Icons.lightbulb_outline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: accent.withValues(alpha: 0.20)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: accent, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                height: 1.45,
                color: AppColors.deep,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Card bianca con padding e bordo morbido.
class SoftCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  const SoftCard(
      {super.key,
      required this.child,
      this.padding = const EdgeInsets.all(16)});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE8ECF5)),
      ),
      child: child,
    );
  }
}

/// Etichetta di un gruppo di campi.
class FieldLabel extends StatelessWidget {
  final String text;
  const FieldLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, top: 4),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: AppColors.deep,
        ),
      ),
    );
  }
}

/// Gruppo di pulsanti a scelta singola.
class ChoiceRow extends StatelessWidget {
  final List<String> options;
  final int? selected;
  final ValueChanged<int> onSelect;
  final Color accent;

  const ChoiceRow({
    super.key,
    required this.options,
    required this.selected,
    required this.onSelect,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < options.length; i++) ...[
          Expanded(
            child: GestureDetector(
              onTap: () => onSelect(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: selected == i ? accent : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: selected == i ? accent : const Color(0xFFE1E6F0),
                  ),
                ),
                child: Text(
                  options[i],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: selected == i ? Colors.white : AppColors.muted,
                  ),
                ),
              ),
            ),
          ),
          if (i < options.length - 1) const SizedBox(width: 8),
        ]
      ],
    );
  }
}

/// Campo di testo che persiste su ogni modifica.
class JournalField extends StatefulWidget {
  final String initial;
  final String hint;
  final int maxLines;
  final ValueChanged<String> onChanged;

  const JournalField({
    super.key,
    required this.initial,
    required this.onChanged,
    this.hint = '',
    this.maxLines = 1,
  });

  @override
  State<JournalField> createState() => _JournalFieldState();
}

class _JournalFieldState extends State<JournalField> {
  late final TextEditingController _c;

  @override
  void initState() {
    super.initState();
    _c = TextEditingController(text: widget.initial);
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _c,
      maxLines: widget.maxLines,
      minLines: widget.maxLines > 1 ? 2 : 1,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(hintText: widget.hint),
      onChanged: widget.onChanged,
    );
  }
}
