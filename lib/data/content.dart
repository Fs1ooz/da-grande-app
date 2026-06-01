/// Tutti i contenuti testuali del fascicolo "Da Grande".
/// Tenuti separati dalla logica per essere facilmente modificabili.
library;

/// Ruota della Vita: 8 aree, 5 domande ciascuna.
/// Risposta: Si = 2, Parzialmente = 1, No = 0. Massimo per area = 10.
const List<MapEntry<String, List<String>>> wheelAreas = [
  MapEntry('Identita e Autostima', [
    'So dire con chiarezza chi sono.',
    'Mi sento a mio agio con me stesso.',
    'Non ho paura di mostrare le mie opinioni.',
    'Mi accetto anche nei miei difetti.',
    'Sono orgoglioso della persona che sto diventando.',
  ]),
  MapEntry('Talenti e Capacita', [
    'So riconoscere almeno un mio talento.',
    'Uso spesso le mie capacita.',
    'Mi piace imparare cose nuove.',
    'Credo che cio che so fare abbia valore.',
    'Mi sento motivato a migliorarmi.',
  ]),
  MapEntry('Relazioni e Amicizie', [
    'Ho almeno un amico vero su cui posso contare.',
    'Mi sento parte di un gruppo.',
    'Riesco a farmi ascoltare dagli altri.',
    'Sento di poter aiutare chi mi sta vicino.',
    'Le mie amicizie mi fanno crescere.',
  ]),
  MapEntry('Famiglia e Radici', [
    'In famiglia mi sento accettato.',
    'Sento che le mie radici mi sostengono.',
    'Riesco a comunicare con almeno un familiare.',
    'Sento che qualcuno in famiglia crede in me.',
    'La mia famiglia e un punto di forza per me.',
  ]),
  MapEntry('Scuola e Formazione', [
    'Credo che la scuola serva al mio futuro.',
    'Riesco a impegnarmi nello studio.',
    'Mi sento capace di affrontare le sfide scolastiche.',
    'Vedo utilita in quello che imparo.',
    'Riesco a gestire il tempo per studiare.',
  ]),
  MapEntry('Tempo Libero e Divertimento', [
    'Dedico tempo alle mie passioni.',
    'Ho attivita che mi fanno sentire vivo.',
    'Riesco a bilanciare impegni e svago.',
    'Il tempo libero mi rigenera.',
    'Riesco a divertirmi senza annoiarmi.',
  ]),
  MapEntry('Salute ed Energia', [
    'Dormo abbastanza per sentirmi bene.',
    'Mi prendo cura della mia alimentazione.',
    'Ho energia durante la giornata.',
    'Faccio movimento o sport.',
    'Mi sento bene fisicamente.',
  ]),
  MapEntry('Direzione e Futuro', [
    'Ho un sogno o obiettivo che mi guida.',
    'So in che direzione voglio andare.',
    'Riesco a immaginarmi tra 5 anni.',
    'Faccio piccoli passi verso il mio futuro.',
    'Credo che il mio futuro possa essere positivo.',
  ]),
];

/// Etichette brevi per i raggi della ruota (per non sovrapporre il testo).
const List<String> wheelShortLabels = [
  'Identita',
  'Talenti',
  'Relazioni',
  'Famiglia',
  'Scuola',
  'Tempo libero',
  'Salute',
  'Futuro',
];

/// Test sulle Intelligenze Multiple (Gardner): 9 intelligenze, 5 item ciascuna.
/// Scala: 0 = Per niente, 1 = Poco, 2 = Abbastanza, 3 = Molto. Massimo = 15.
const List<MapEntry<String, List<String>>> intelligences = [
  MapEntry('Linguistica', [
    'Mi piace leggere con costanza.',
    'Scrivo volentieri (racconti, testi, post, diario).',
    'Trovo parole chiare per spiegare o convincere.',
    'Colgo sfumature di significato e di tono.',
    'Mi divertono giochi linguistici (rime, anagrammi, cruciverba).',
  ]),
  MapEntry('Logico-Matematica', [
    'Mi piacciono rompicapi e giochi di logica.',
    'Scompongo problemi in passi ordinati.',
    'Faccio calcoli a mente con facilita.',
    'Riconosco pattern e regolarita nei dati o nelle situazioni.',
    'Formulo ipotesi e le metto alla prova.',
  ]),
  MapEntry('Spaziale', [
    'Visualizzo mentalmente oggetti o ambienti ruotati.',
    'Capisco mappe, grafici e schemi al primo colpo.',
    'Mi oriento bene in luoghi nuovi.',
    'Disegno o progetto volentieri (anche schizzi rapidi).',
    'Ho senso di proporzioni, composizione e dettagli visivi.',
  ]),
  MapEntry('Corporeo-Cinestetica', [
    'Imparo meglio facendo e sperimentando.',
    'Mi piace muovermi (sport, danza, arti marziali).',
    'Ho buona coordinazione e manualita fine.',
    'So replicare movimenti o gesti con precisione.',
    'So costruire, assemblare o aggiustare oggetti.',
  ]),
  MapEntry('Musicale', [
    'Riconosco facilmente ritmo e melodia.',
    'Canto o suono (o imparo velocemente a farlo).',
    'Ricordo facilmente brani e motivi.',
    'Distinguo cambi di tempo o di intonazione.',
    'Creo playlist o beat, oppure mi piace comporre.',
  ]),
  MapEntry('Interpersonale', [
    'Colgo emozioni e bisogni degli altri.',
    'Collaboro bene e facilito i gruppi.',
    'Modulo il mio modo di comunicare a seconda di chi ho davanti.',
    'So gestire o mediare i conflitti.',
    'Do e chiedo feedback in modo costruttivo.',
  ]),
  MapEntry('Intrapersonale', [
    'Mi osservo: riconosco emozioni, valori, motivazioni.',
    'Conosco i miei punti di forza e le aree da migliorare.',
    'Mi do obiettivi chiari e li seguo nel tempo.',
    'So regolare i miei stati d\'animo.',
    'Sto bene anche da solo; uso diario o note per riflettere.',
  ]),
  MapEntry('Naturalistica', [
    'Sto volentieri nella natura o all\'aperto.',
    'Riconosco (o mi interessa riconoscere) specie vegetali e animali.',
    'Mi incuriosiscono ecosistemi e cicli naturali.',
    'Mi prendo cura di piante o animali e noto i cambiamenti.',
    'Valuto l\'impatto ambientale delle mie scelte.',
  ]),
  MapEntry('Esistenziale', [
    'Mi pongo domande di senso (vita, scelte, "perche").',
    'Mi interessa etica, filosofia o spiritualita (anche in chiave laica).',
    'Cerco coerenza tra pensieri, parole e azioni.',
    'Guardo oltre l\'immediato e valuto il lungo periodo.',
    'Trovo significato personale anche nelle difficolta.',
  ]),
];

/// Le 10 domande di "Mi Presento: chi voglio essere da oggi - Fase 1".
const List<String> presentationQuestions = [
  'Quale etichetta positiva del passato (identita ricordata) porto con me?',
  'Cosa voglio che gli altri pensino di me attraverso la mia vita?',
  'Io voglio... (puoi fare riferimento all\'identita programmata)',
  'Quali talenti naturali riconosco in me?',
  'Quali capacita mi danno piu forza?',
  'Quali risorse interiori voglio che mi sostengano nei momenti difficili?',
  'Quali sono i 3 valori principali che voglio incarnare?',
  'Qual e la convinzione che mi guidera?',
  'Che impatto voglio lasciare sugli altri, anche piccolo?',
  'Se fossi un\'immagine, un simbolo o una metafora, cosa saresti?',
];

/// Le 3 domande di riflessione della sezione "Sono un miracolo".
const List<String> miracleQuestions = [
  'Ora che sei consapevole di essere "1 su 300 milioni", cosa cambia nel tuo modo di guardarti?',
  'In quali momenti della tua vita hai sentito che "esserci" era gia qualcosa di speciale?',
  'Immagina di guardarti allo specchio: cosa e importante che tu ti dica, ora che sai di essere un miracolo?',
];

/// Genera il "proclama di vita" inserendo le risposte della Fase 1
/// nello schema del fascicolo (Fase 2).
String buildDeclaration(String name, Map<int, String> a) {
  String pick(int i, String fallback) {
    final v = (a[i] ?? '').trim();
    return v.isEmpty ? fallback : v;
  }

  final nome = name.trim().isEmpty ? '_____' : name.trim();
  final q1 = pick(0, '_____');
  final q4 = pick(3, '_____');
  final q5 = pick(4, '_____');
  final q9 = pick(8, '_____');
  final q6 = pick(5, '_____');
  final q7 = pick(6, '_____');
  final q8 = pick(7, '_____');
  final q10 = pick(9, '_____');

  return '''Mi chiamo $nome.

Oggi mi presento consapevole della mia vita: un percorso che non sapevo portasse con se tanta ricchezza e tante domande senza risposta. Ho osservato la mia giovane vita e, tra le tante dinamiche, avventure, gioie e sfide, mi sono reso conto, nonostante tutto, di essere stato $q1.

Da oggi cammino nella mia vita portando con me $q4: i miei talenti, i doni che ho deciso di mettere a servizio del miracolo della vita che mi e stata donata.

Insieme a questi $q5, ovvero le capacita che ho imparato a conquistare, per essere utile agli altri.

Ed e per questo che voglio $q9, e cosi lasciare il mio segno, la mia impronta.

Ho capito e ho imparato che il valore delle cose e dato dall'esercizio che sono chiamato a intraprendere, e che dietro ogni piccolo o grande traguardo potro attraversare momenti difficili. Sara proprio in quei momenti che attingero a $q6, le risorse che la vita mi ha donato, e cosi restero fedele a $q7, cioe i valori che guidano la mia rotta.

Credo fortemente che $q8.

Da oggi voglio pensare, agire e impegnarmi in direzione della mia felicita, dei miei sogni e della mia realizzazione, consapevole che il mio valore non e fine a se stesso, non e vincolato ai miei traguardi o ai miei errori, ma e un dono utile per gli altri.

Oggi sono $q10, perche sento che in esso c'e la mia essenza, la mia forza, la mia promessa al mondo.''';
}
