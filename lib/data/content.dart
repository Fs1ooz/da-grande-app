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

/// Testi introduttivi per ogni sezione, tratti dal fascicolo.
const Map<String, String> sectionIntros = {
  'welcome': '''Stai per iniziare un viaggio speciale.
Non un viaggio fatto di valigie e treni, ma un viaggio dentro te stesso, tra domande, scoperte ed esperienze che ti aiuteranno a capire meglio chi sei, cosa vuoi e come puoi diventarlo.

Questo workbook non è un quaderno qualsiasi: è il tuo spazio personale, un luogo dove potrai scrivere, riflettere, giocare e mettere in ordine i tuoi pensieri. Non esistono risposte giuste o sbagliate: esistono solo le tue risposte, quelle che valgono davvero perché parlano di te.

Qui troverai esercizi, domande potenti e attività che ti aiuteranno a tirare fuori il meglio di ciò che hai dentro. Alcune ti faranno sorridere, altre ti faranno pensare, altre ancora ti sorprenderanno. Ma tutte hanno un unico obiettivo: aiutarti a crescere e a riconoscere le tue risorse.

Ricorda: ciò che scrivi qui è solo tuo. Puoi essere sincero, autentico, persino un po' ribelle.
Perché questo non è un compito: è la tua avventura.

Preparati a partire: ogni pagina è una tappa del tuo cammino.

E chissà... forse alla fine scoprirai che il futuro non è un mistero da temere, ma un'opera che puoi iniziare a scrivere già oggi, con coraggio e immaginazione.''',

  'wheel': '''La Ruota della Vita è come uno specchio: ti mostra in un colpo d'occhio quanto equilibrio c'è tra le diverse aree importanti per te. È uno strumento che serve a vedere con chiarezza dove stai bene e dove puoi crescere. Non è un voto sulla tua vita, ma una bussola per orientarti: più la ruota è armonica, più il tuo viaggio scorre fluido.

Come funziona:
- Ogni area ha 5 domande.
- Rispondi con Sì (2 punti), Parzialmente (1 punto) o No (0 punti).
- Alla fine somma i punti e osserva la forma della tua ruota.''',

  'remembered': '''L'identità ricordata nasce da episodi che ti porti ancora addosso. A volte sono vittorie che ti hanno dato forza, altre volte ferite che sembrano averti definito. Non si tratta di cancellarli, ma di guardare in faccia quei ricordi e scegliere se tenerli o lasciarli andare.

Un momento che potenzia: "In prima superiore ho parlato davanti alla classe anche se tremavo. Da allora so che posso farcela." → Etichetta: Coraggioso.

Un momento che depotenzia: "In terza media ho sbagliato una gara e mi sono convinto di non essere portato." → Etichetta: Non all'altezza.

Scrivi fino a 5 episodi che ti potenziano e fino a 5 che ti depotenziano. Accanto a ognuno dai un'etichetta e decidi: la tengo o la lascio andare?''',

  'reflected': '''L'identità riflessa è l'immagine che ti arriva da fuori: quello che gli altri dicono di te, le etichette che ti appiccicano addosso. A volte ti danno forza, a volte ti limitano. Il rischio è crederci così tanto da comportarti come se fossero vere, anche quando non ti appartengono.

Ti dicono: "Sei sempre distratto." Alla lunga, inizi a pensarlo anche tu e a comportarti da distratto.
Oppure: "Hai talento con le parole." Ti convince e ti spinge a provarci di più.

Scrivi fino a 5 frasi che ti sono state dette su di te. Per ognuna chiediti: "Questa frase mi rappresenta davvero?" Poi riscrivila in una versione più vera per te.''',

  'potential': '''Dentro di te c'è più di quanto immagini: il potenziale non è un numero, ma una direzione.

Il potenziale è l'insieme di ciò che sei oggi, di ciò che puoi diventare e di ciò che ancora non sai di avere. Non è qualcosa di visibile subito, ma una forza che si rivela quando scegli di metterti in gioco.

Il potenziale è un patrimonio interiore che si compone di tre parti:

Talenti: le tue predisposizioni naturali, cose che ti riescono bene con facilità, che ti vengono spontanee.

Risorse interiori: la tua benzina psicologica ed emotiva — coraggio, pazienza, resilienza, creatività.

Capacità allenate: le abilità che sviluppi con impegno, studio e pratica. All'inizio sembrano difficili, ma con la costanza diventano parte di te.

Ricorda: non sei definito solo da quello che sai già fare. Il tuo potenziale si scopre vivendo, provando, sbagliando, rialzandoti.''',

  'intelligences': '''Questo strumento ti aiuta a riconoscere le tue preferenze cognitive e i tuoi talenti secondo la teoria delle Intelligenze Multiple di Howard Gardner. Non è un test clinico né un giudizio di valore: offre una fotografia attuale delle tue inclinazioni, che possono evolvere con l'allenamento e l'esperienza.

Istruzioni:
1. Leggi ogni affermazione e valuta quanto ti rappresenta.
2. Segna una sola risposta per affermazione. Rispondi in base a come sei di solito, non come vorresti essere.
3. Compila tutti gli item.

Scala: 0 = Per niente / 1 = Poco / 2 = Abbastanza / 3 = Molto''',

  'programmed': '''A volte gli altri parlano del tuo futuro come se fosse già scritto. Ma il futuro non è una profezia: è una scelta.

L'identità programmata è fatta delle frasi che senti dire su chi diventerai o su cosa "dovresti fare". Possono motivarti, ma possono anche diventare una gabbia se ti limiti a ciò che gli altri immaginano per te.

Esempi di frasi degli altri:
- "Diventerai un ingegnere come tuo padre."
- "Dovresti iscriverti a medicina."
- "Non sei fatto per stare sul palco."

Per ogni frase: segna se la senti Motivante (ti dà spinta e ti appartiene) o Limitante (non la senti tua, ti imprigiona). Poi riscrivila iniziando con "Io voglio..."''',

  'values': '''I valori sono ciò che conta davvero per te. Sono come una bussola che ti indica la direzione da seguire nella vita. Quando vivi rispettando i tuoi valori, ti senti in equilibrio e felice; quando invece li tradisci, ti senti in conflitto o smarrito.

Immagina i valori come il GPS della tua vita: se sono chiari, sai dove andare; se sono confusi, rischi di girare in tondo.

Non tutti i valori sono uguali. Alcuni sono mezzi (strumenti per raggiungere qualcosa), altri sono fini (la destinazione, ciò che vuoi davvero vivere e provare).

Attenzione: a volte un valore interpretato "male" può diventare una gabbia. La vera libertà, per esempio, è anche scegliere responsabilmente.

Avere chiari i propri valori è importante, ma non basta. Per vivere davvero secondo i tuoi valori hai bisogno di criteri — le regole personali che ti fanno capire quando quel valore è presente nella tua vita. I criteri sono come semafori interiori: senza di essi, i valori restano idee astratte.''',

  'miracle': '''"Le probabilità che tu fossi qui apparirebbero praticamente nulle. Eppure esisti. Questo non è un caso: è il segno che la tua vita ha un valore che supera ogni statistica. Adesso è il tuo turno di riconoscerlo."

Un miracolo non è solo qualcosa che accade fuori da noi. Tu sei già un miracolo. La tua esistenza non era scontata: eri una probabilità infinitesimale. Eppure sei qui. Prima ancora di scoprire chi sei e cosa sai fare, ricordati che esserci è già straordinario.

Chiudi gli occhi e immagina la scena: milioni di possibilità corrono, solo una arriva.
Ora apri gli occhi e rispondi alle domande qui sotto.''',

  'created': '''Non sei soltanto quello che sei stato, né l'immagine che gli altri hanno di te. Non sei nemmeno ciò che ti hanno detto che diventerai.
Sei molto di più: sei la possibilità di scegliere chi vuoi essere da oggi in poi.

L'identità creata è la più potente di tutte, perché non dipende dal passato né dalle opinioni degli altri. È la parte che nasce dalle tue scelte, dalla tua capacità di decidere come vivere e quale direzione prendere.

Non significa inventarti qualcosa che non esiste, ma costruire, giorno dopo giorno, la versione di te che senti più autentica.

- Se l'identità ricordata parla dei tuoi ricordi,
- se l'identità riflessa parla di come ti vedono gli altri,
- se l'identità programmata racconta le aspettative che ti sono state messe addosso,
l'identità creata è invece la tua voce libera che dice: "Io scelgo di essere questo."

Perché il punto non è chi eri o cosa gli altri hanno pensato di te. Il punto è chi decidi di essere oggi.''',
};

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
