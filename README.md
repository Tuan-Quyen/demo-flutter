# demo-flutter

> 🗄️ **2019 learning project, no longer maintained.** One of my first Flutter experiments. Kept for history.

A minimal Flutter starter I set up in 2019 while moving from native Android to Flutter. It contains the app shell (`MaterialApp` → `HomePage`) and the dependencies I was evaluating at the time:

| Package | Why it was here |
|---|---|
| `provider` | Trying state management before settling on BLoC in later projects |
| `flutter_slidable` | Swipe actions on list items |

**Stack:** Flutter (Dart 2, 2019), Android + iOS runners

## Run

Built against a 2019 Flutter SDK. On a current SDK you will need to upgrade the Android Gradle setup and dependencies first.

```bash
flutter pub get
flutter run
```

## Where this led

My production Flutter work since then uses BLoC, Clean Architecture, GetIt, Dio + Retrofit codegen and bloc_test. See my [portfolio](https://quyenchau.pages.dev) or [qcsocial](https://github.com/Tuan-Quyen/qcsocial) for a fuller example.

---

**Quyen Chau** · [Portfolio & CV](https://quyenchau.pages.dev) · [GitHub](https://github.com/Tuan-Quyen)
