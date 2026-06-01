# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Da Grande** is an offline Flutter app guiding users through an 8-stage self-discovery journey based on the Italian workbook "Da Grande - Manuale Operativo & Diario di Bordo". Users explore identity, values, talents, and life goals through interactive questionnaires and visualizations.

- Fully offline; all data persisted locally via SharedPreferences
- Custom radar chart (no external charting library) for Wheel of Life and Multiple Intelligences
- Reset option in home menu clears all data with confirmation

## Tech Stack

- **Flutter** / Dart SDK 3.0.0+
- **State Management**: `provider` v6.1.0 — single `ChangeNotifier`
- **Local Storage**: `shared_preferences` v2.2.0
- **UI**: Material Design 3 with custom `AppColors` palette
- **Graphics**: `CustomPainter` only — no external chart libs

## Commands

```bash
# Dependencies
flutter pub get

# Run
flutter run
flutter run -d <device-id>

# Test & lint
flutter test
flutter test test/widget_test.dart
flutter analyze

# Build
flutter build apk --release
flutter build appbundle
flutter build ios --release
flutter build web
```

> On first setup, regenerate platform folders with `flutter create .`

## Architecture

### State Management

Single `AppState extends ChangeNotifier` (`lib/state/app_state.dart`) wraps the entire app via `ChangeNotifierProvider` in `main.dart`. It holds a `JourneyData` instance and exposes computed properties (`wheelScores()`, `intelScores()`, `isComplete(Stage)`, `progress`).

UI reads state via `context.watch<AppState>()` or `context.read<AppState>()`. Every mutation modifies `state.data` directly, then calls `state.save()` explicitly — there is no auto-save.

### Loading Pattern

`AppState.load()` runs in `main()` before `runApp`. A `_LoadingGate` widget in `main.dart` shows a spinner until `loaded == true`, then swaps to `HomeScreen`.

### Data Persistence

`JourneyData` serializes to/from JSON via `encode()` / `JourneyData.decode(raw)`. Stored under key `da_grande_journey_v1`. Missing/corrupt data falls back to `JourneyData.empty()`. `Map<int, String>` (the `presentation` field) converts int keys to strings for JSON compatibility.

Padding helpers (`_padEpisodes`, `_padReflected`, etc.) in `journey_data.dart` ensure lists always reach their minimum length on decode — no validation throws.

### Stage Lifecycle

8 stages defined as `enum Stage` in `app_state.dart`: `wheel → remembered → reflected → potential → programmed → values → miracle → created`. `StageList.all` is the canonical ordered list.

`AppState.isComplete(Stage s)` computes completion on demand (no caching). Completion rules:
- **wheel**: all 40 cells ≥ 0 (no `-1`)
- **remembered**: any `empowering` entry has non-empty `text`
- **reflected**: any `reflected` entry has non-empty `said`
- **potential**: any `talenti` non-empty **and** all 45 intel cells ≥ 0
- **programmed**: any `programmed` entry has non-empty `said`
- **values**: any `values` entry has non-empty `value`
- **miracle**: any `miracle` string non-empty
- **created**: `declaration` non-empty **or** any `presentation` answer non-empty

### Navigation

Plain `Navigator.push/pop` — no routing library. `HomeScreen` renders all 8 stage tiles; tapping pushes the dedicated screen. All stage screens use `SectionScaffold` from `widgets/common.dart`.

### Content Layer

`lib/data/content.dart` holds all hardcoded Italian text: `wheelAreas` (8×5 questions), `intelligences` (9×5 items), and `buildDeclaration()` which generates the final life proclamation from `name` + `presentation` answers.

## Data Model (`lib/models/journey_data.dart`)

| Field | Type | Description |
|---|---|---|
| `wheel` | `List<List<int>>` 8×5 | -1=unanswered, 0/1/2 score |
| `wheelObservations` | `String` | Free-text reflection |
| `empowering` / `disempowering` | `List<EpisodeEntry>` (5 each) | Remembered identity episodes |
| `reflected` | `List<ReflectedPhrase>` (5) | What others said about you |
| `talenti`, `risorse`, `capacita` | `List<String>` (3 each) | Potential stage inputs |
| `intel` | `List<List<int>>` 9×5 | Multiple Intelligences scores |
| `programmed` | `List<ProgrammedPhrase>` (5) | Voices about your future |
| `values` | `List<ValueEntry>` (3) | Core values + 3 criteria each |
| `miracle` | `List<String>` (3) | What makes you unique |
| `name` | `String` | User's name |
| `presentation` | `Map<int, String>` | "Who are you?" answers by question index |
| `declaration` | `String` | Generated life proclamation |

Key model fields:
- `EpisodeEntry`: `text`, `label`, `keep` (bool — keep or release this identity)
- `ReflectedPhrase`: `said`, `mirrors` (0=No, 1=Partially, 2=Yes), `rewritten`
- `ProgrammedPhrase`: `said`, `motivating` (bool), `iWant`
- `ValueEntry`: `value`, `criteria` (List\<String\> of 3)

## Theme & Colors

`lib/theme.dart` — `buildTheme()` creates a Material 3 `ColorScheme`. `AppColors.stageColors` is a list aligned to `StageList.all` order; each stage gets a unique accent color. Palette includes ink (navy), primary (bright blue), cyan, amber, coral, mint.

## Test Coverage

Only a placeholder smoke test exists in `test/widget_test.dart`. Stage completion logic and JSON serialization are untested.
