import 'dart:convert';

/// Un episodio della "Identita Ricordata".
class EpisodeEntry {
  String text;
  String label;
  bool keep; // true = tengo questa identita, false = la lascio andare
  // Campi extra per gli episodi potenzianti (lasciati vuoti nei depotenzianti)
  String imparato;
  String replicare;
  String impatti;

  EpisodeEntry({
    this.text = '',
    this.label = '',
    this.keep = true,
    this.imparato = '',
    this.replicare = '',
    this.impatti = '',
  });

  Map<String, dynamic> toJson() => {
        'text': text,
        'label': label,
        'keep': keep,
        'imparato': imparato,
        'replicare': replicare,
        'impatti': impatti,
      };

  factory EpisodeEntry.fromJson(Map<String, dynamic> j) => EpisodeEntry(
        text: j['text'] as String? ?? '',
        label: j['label'] as String? ?? '',
        keep: j['keep'] as bool? ?? true,
        imparato: j['imparato'] as String? ?? '',
        replicare: j['replicare'] as String? ?? '',
        impatti: j['impatti'] as String? ?? '',
      );
}

/// Una frase ricevuta dagli altri, riscritta nella "Identita Riflessa".
class ReflectedPhrase {
  String said;
  int mirrors; // 0 = No, 1 = Parzialmente, 2 = Si
  String rewritten;

  ReflectedPhrase({this.said = '', this.mirrors = 1, this.rewritten = ''});

  Map<String, dynamic> toJson() =>
      {'said': said, 'mirrors': mirrors, 'rewritten': rewritten};

  factory ReflectedPhrase.fromJson(Map<String, dynamic> j) => ReflectedPhrase(
        said: j['said'] as String? ?? '',
        mirrors: j['mirrors'] as int? ?? 1,
        rewritten: j['rewritten'] as String? ?? '',
      );
}

/// Una frase sul futuro ricevuta dagli altri, "Identita Programmata".
class ProgrammedPhrase {
  String said;
  bool motivating; // true = motivante, false = limitante
  String iWant;

  ProgrammedPhrase({this.said = '', this.motivating = true, this.iWant = ''});

  Map<String, dynamic> toJson() =>
      {'said': said, 'motivating': motivating, 'iWant': iWant};

  factory ProgrammedPhrase.fromJson(Map<String, dynamic> j) => ProgrammedPhrase(
        said: j['said'] as String? ?? '',
        motivating: j['motivating'] as bool? ?? true,
        iWant: j['iWant'] as String? ?? '',
      );
}

/// Un valore con i suoi criteri di vita.
class ValueEntry {
  String value;
  List<String> criteria;

  ValueEntry({this.value = '', List<String>? criteria})
      : criteria = criteria ?? ['', '', ''];

  Map<String, dynamic> toJson() => {'value': value, 'criteria': criteria};

  factory ValueEntry.fromJson(Map<String, dynamic> j) => ValueEntry(
        value: j['value'] as String? ?? '',
        criteria: (j['criteria'] as List?)?.map((e) => e.toString()).toList() ??
            ['', '', ''],
      );
}

/// Tutti i dati del percorso dell'utente.
class JourneyData {
  // Ruota della Vita: 8 aree x 5 risposte. -1 = non risposto, 0/1/2.
  List<List<int>> wheel;
  String wheelObservations;

  // Identita Ricordata
  List<EpisodeEntry> empowering;
  List<EpisodeEntry> disempowering;

  // Identita Riflessa
  List<ReflectedPhrase> reflected;

  // Potenziale
  List<String> talenti;
  List<String> risorse;
  List<String> capacita;
  List<List<int>> intel; // 9 intelligenze x 5 risposte. -1 = non risposto.

  // Identita Programmata
  List<ProgrammedPhrase> programmed;

  // Valori
  List<ValueEntry> values;

  // Sono un miracolo
  List<String> miracle;

  // Identita Creata - Mi Presento
  String name;
  Map<int, String> presentation; // indice domanda -> risposta
  String declaration;

  JourneyData({
    required this.wheel,
    this.wheelObservations = '',
    required this.empowering,
    required this.disempowering,
    required this.reflected,
    required this.talenti,
    required this.risorse,
    required this.capacita,
    required this.intel,
    required this.programmed,
    required this.values,
    required this.miracle,
    this.name = '',
    required this.presentation,
    this.declaration = '',
  });

  /// Stato iniziale vuoto.
  factory JourneyData.empty() => JourneyData(
        wheel: List.generate(8, (_) => List.filled(5, -1)),
        empowering: List.generate(5, (_) => EpisodeEntry()),
        disempowering: List.generate(5, (_) => EpisodeEntry(keep: false)),
        reflected: List.generate(5, (_) => ReflectedPhrase()),
        talenti: ['', '', ''],
        risorse: ['', '', ''],
        capacita: ['', '', ''],
        intel: List.generate(9, (_) => List.filled(5, -1)),
        programmed: List.generate(5, (_) => ProgrammedPhrase()),
        values: List.generate(3, (_) => ValueEntry()),
        miracle: ['', '', ''],
        presentation: {},
      );

  Map<String, dynamic> toJson() => {
        'wheel': wheel,
        'wheelObservations': wheelObservations,
        'empowering': empowering.map((e) => e.toJson()).toList(),
        'disempowering': disempowering.map((e) => e.toJson()).toList(),
        'reflected': reflected.map((e) => e.toJson()).toList(),
        'talenti': talenti,
        'risorse': risorse,
        'capacita': capacita,
        'intel': intel,
        'programmed': programmed.map((e) => e.toJson()).toList(),
        'values': values.map((e) => e.toJson()).toList(),
        'miracle': miracle,
        'name': name,
        'presentation': presentation.map((k, v) => MapEntry(k.toString(), v)),
        'declaration': declaration,
      };

  String encode() => jsonEncode(toJson());

  static List<List<int>> _grid(dynamic raw, int rows, int cols) {
    if (raw is List) {
      return List.generate(rows, (i) {
        if (i < raw.length && raw[i] is List) {
          final row = raw[i] as List;
          return List.generate(
              cols, (j) => j < row.length ? (row[j] as num).toInt() : -1);
        }
        return List.filled(cols, -1);
      });
    }
    return List.generate(rows, (_) => List.filled(cols, -1));
  }

  static List<String> _strList(dynamic raw, int min) {
    final out = raw is List ? raw.map((e) => e.toString()).toList() : <String>[];
    while (out.length < min) {
      out.add('');
    }
    return out;
  }

  static List _jsonList(dynamic raw) => raw is List ? raw : const [];

  factory JourneyData.fromJson(Map<String, dynamic> j) {
    final pres = <int, String>{};
    final rawPres = j['presentation'];
    if (rawPres is Map) {
      rawPres.forEach((k, v) {
        final idx = int.tryParse(k.toString());
        if (idx != null) pres[idx] = v.toString();
      });
    }
    return JourneyData(
      wheel: _grid(j['wheel'], 8, 5),
      wheelObservations: j['wheelObservations'] as String? ?? '',
      empowering: _jsonList(j['empowering'])
          .whereType<Map>()
          .map((e) => EpisodeEntry.fromJson(Map<String, dynamic>.from(e)))
          .toList()
          .let((list) => _padEpisodes(list, true)),
      disempowering: _jsonList(j['disempowering'])
          .whereType<Map>()
          .map((e) => EpisodeEntry.fromJson(Map<String, dynamic>.from(e)))
          .toList()
          .let((list) => _padEpisodes(list, false)),
      reflected: _jsonList(j['reflected'])
          .whereType<Map>()
          .map((e) => ReflectedPhrase.fromJson(Map<String, dynamic>.from(e)))
          .toList()
          .let((list) => _padReflected(list)),
      talenti: _strList(j['talenti'], 3),
      risorse: _strList(j['risorse'], 3),
      capacita: _strList(j['capacita'], 3),
      intel: _grid(j['intel'], 9, 5),
      programmed: _jsonList(j['programmed'])
          .whereType<Map>()
          .map((e) => ProgrammedPhrase.fromJson(Map<String, dynamic>.from(e)))
          .toList()
          .let((list) => _padProgrammed(list)),
      values: _jsonList(j['values'])
          .whereType<Map>()
          .map((e) => ValueEntry.fromJson(Map<String, dynamic>.from(e)))
          .toList()
          .let((list) => _padValues(list)),
      miracle: _strList(j['miracle'], 3),
      name: j['name'] as String? ?? '',
      presentation: pres,
      declaration: j['declaration'] as String? ?? '',
    );
  }

  static JourneyData decode(String source) =>
      JourneyData.fromJson(jsonDecode(source) as Map<String, dynamic>);

  static List<EpisodeEntry> _padEpisodes(List<EpisodeEntry> l, bool keep) {
    while (l.length < 5) {
      l.add(EpisodeEntry(keep: keep));
    }
    return l;
  }

  static List<ReflectedPhrase> _padReflected(List<ReflectedPhrase> l) {
    while (l.length < 5) {
      l.add(ReflectedPhrase());
    }
    return l;
  }

  static List<ProgrammedPhrase> _padProgrammed(List<ProgrammedPhrase> l) {
    while (l.length < 5) {
      l.add(ProgrammedPhrase());
    }
    return l;
  }

  static List<ValueEntry> _padValues(List<ValueEntry> l) {
    while (l.length < 3) {
      l.add(ValueEntry());
    }
    return l;
  }
}

/// Piccola estensione di comodo per concatenare trasformazioni.
extension _Let<T> on T {
  R let<R>(R Function(T) op) => op(this);
}
