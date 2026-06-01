import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/content.dart';
import '../models/journey_data.dart';

/// Le tappe del percorso, nell'ordine del fascicolo.
enum Stage {
  wheel,
  remembered,
  reflected,
  potential,
  programmed,
  valori,
  miracle,
  created,
}

extension StageInfo on Stage {
  String get title {
    switch (this) {
      case Stage.wheel:
        return 'La Ruota della Vita';
      case Stage.remembered:
        return 'Identita Ricordata';
      case Stage.reflected:
        return 'Identita Riflessa';
      case Stage.potential:
        return 'Il Tuo Potenziale';
      case Stage.programmed:
        return 'Identita Programmata';
      case Stage.valori:
        return 'I Valori della Tua Vita';
      case Stage.miracle:
        return 'Sono un Miracolo';
      case Stage.created:
        return 'Identita Creata';
    }
  }

  String get subtitle {
    switch (this) {
      case Stage.wheel:
        return 'Dove stai bene e dove puoi crescere';
      case Stage.remembered:
        return 'Fase 1 - gli episodi che ti porti addosso';
      case Stage.reflected:
        return 'Fase 2 - cio che gli altri dicono di te';
      case Stage.potential:
        return 'Talenti, risorse, capacita e intelligenze';
      case Stage.programmed:
        return 'Fase 3 - le voci sul tuo futuro';
      case Stage.valori:
        return 'La bussola che guida le tue scelte';
      case Stage.miracle:
        return '1 su 300 milioni';
      case Stage.created:
        return 'Fase 4 - chi scelgo di essere da oggi';
    }
  }
}

class AppState extends ChangeNotifier {
  JourneyData data = JourneyData.empty();
  SharedPreferences? _prefs;
  static const _key = 'da_grande_journey_v1';
  static const _darkKey = 'da_grande_dark_v1';
  static const _unlockKey = 'da_grande_unlock_all_v1';
  static const _welcomeKey = 'da_grande_welcome_v1';
  bool loaded = false;
  bool isDark = false;
  bool allUnlocked = false;
  bool welcomeSeen = false;

  Future<void> load() async {
    _prefs = await SharedPreferences.getInstance();
    final raw = _prefs?.getString(_key);
    if (raw != null && raw.isNotEmpty) {
      try {
        data = JourneyData.decode(raw);
      } catch (_) {
        data = JourneyData.empty();
      }
    }
    isDark = _prefs?.getBool(_darkKey) ?? false;
    allUnlocked = _prefs?.getBool(_unlockKey) ?? false;
    welcomeSeen = _prefs?.getBool(_welcomeKey) ?? false;
    loaded = true;
    notifyListeners();
  }

  /// Salva su disco. Da chiamare dopo ogni modifica.
  Future<void> save({bool notify = false}) async {
    assert(_prefs != null, 'save() chiamato prima che load() completasse');
    await _prefs?.setString(_key, data.encode());
    if (notify) notifyListeners();
  }

  void notify() => notifyListeners();

  Future<void> toggleDark() async {
    isDark = !isDark;
    await _prefs?.setBool(_darkKey, isDark);
    notifyListeners();
  }

  Future<void> markWelcomeSeen() async {
    welcomeSeen = true;
    await _prefs?.setBool(_welcomeKey, true);
    notifyListeners();
  }

  Future<void> toggleUnlockAll() async {
    allUnlocked = !allUnlocked;
    await _prefs?.setBool(_unlockKey, allUnlocked);
    notifyListeners();
  }

  Future<void> reset() async {
    data = JourneyData.empty();
    await save();
    notifyListeners();
  }

  // ---- Calcolo dei punteggi ----

  /// Punteggio per ogni area della Ruota della Vita (0..10).
  List<int> wheelScores() {
    return data.wheel
        .map((row) =>
            row.where((v) => v >= 0).fold<int>(0, (sum, v) => sum + v))
        .toList();
  }

  /// Punteggio per ogni intelligenza (0..15).
  List<int> intelScores() {
    return data.intel
        .map((row) =>
            row.where((v) => v >= 0).fold<int>(0, (sum, v) => sum + v))
        .toList();
  }

  // ---- Avanzamento ----

  bool isComplete(Stage s) {
    switch (s) {
      case Stage.wheel:
        return data.wheel.every((row) => row.every((v) => v >= 0));
      case Stage.remembered:
        return data.empowering.any((e) => e.text.trim().isNotEmpty);
      case Stage.reflected:
        return data.reflected.any((e) => e.said.trim().isNotEmpty);
      case Stage.potential:
        return data.talenti.any((t) => t.trim().isNotEmpty) &&
            data.intel.every((row) => row.every((v) => v >= 0));
      case Stage.programmed:
        return data.programmed.any((e) => e.said.trim().isNotEmpty);
      case Stage.valori:
        return data.values.any((v) => v.value.trim().isNotEmpty);
      case Stage.miracle:
        return data.miracle.any((m) => m.trim().isNotEmpty);
      case Stage.created:
        return data.declaration.trim().isNotEmpty ||
            data.presentation.values.any((v) => v.trim().isNotEmpty);
    }
  }

  bool isLocked(Stage s) {
    if (allUnlocked) return false;
    final i = StageList.all.indexOf(s);
    if (i <= 0) return false;
    return !isComplete(StageList.all[i - 1]);
  }

  double get progress {
    final completed = StageList.all.where(isComplete).length;
    return completed / StageList.all.length;
  }

  Future<String> generateDeclaration() async {
    final text = buildDeclaration(data.name, data.presentation);
    data.declaration = text;
    await save();
    notifyListeners();
    return text;
  }
}

/// Lista ordinata delle tappe.
class StageList {
  static const List<Stage> all = [
    Stage.wheel,
    Stage.remembered,
    Stage.reflected,
    Stage.potential,
    Stage.programmed,
    Stage.valori,
    Stage.miracle,
    Stage.created,
  ];
}
