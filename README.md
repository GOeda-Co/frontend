# frontend

A new Flutter project.

### Frontend Setup (Flutter)

1. Install dependencies:
```bash
flutter pub get
```

2. Generate JSON serialization code:
```bash
flutter packages pub run build_runner build
```

3. Run the app:
```bash
flutter run -d web-server --web-port 8080
```