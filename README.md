# Da Grande

App di sviluppo personale che riproduce il viaggio del fascicolo *Da Grande - Manuale Operativo & Diario di Bordo*.

Il percorso segue esattamente l'ordine del libretto:

1. La Ruota della Vita
2. Identita Ricordata (Fase 1)
3. Identita Riflessa (Fase 2)
4. Il Tuo Potenziale (talenti, risorse, capacita + test sulle Intelligenze Multiple)
5. Identita Programmata (Fase 3)
6. I Valori della Tua Vita
7. Sono un Miracolo (1 su 300 milioni)
8. Identita Creata (Fase 4, con il proclama di vita generato dalle tue risposte)

## Come avviare l'app

Questo pacchetto contiene solo il codice sorgente (cartella `lib/`, `pubspec.yaml`). Le cartelle di piattaforma (android, ios, ecc.) vanno rigenerate sul tuo computer.

1. Assicurati di avere il Flutter SDK installato (`flutter --version`).
2. Apri un terminale dentro la cartella `da_grande_app`.
3. Rigenera le cartelle di piattaforma sopra al codice esistente:

   ```bash
   flutter create .
   ```

4. Scarica le dipendenze:

   ```bash
   flutter pub get
   ```

5. Avvia su un emulatore o su un dispositivo collegato:

   ```bash
   flutter run
   ```

## Note

- L'app funziona completamente offline.
- Tutte le risposte vengono salvate in locale sul dispositivo tramite `shared_preferences`, quindi le ritrovi alla riapertura.
- Dal menu in alto a destra nella schermata principale puoi usare "Ricomincia da capo" per azzerare tutto.

## Dipendenze

- `provider` per la gestione dello stato
- `shared_preferences` per il salvataggio locale

La ruota (radar) e disegnata con un `CustomPainter` interno, senza librerie grafiche esterne.
