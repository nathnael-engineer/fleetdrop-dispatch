# FleetDrop Dispatch Engine 🚚

Real-Time Vehicle Routing and Geospatial Dispatch in Flutter.

## Architecture

- **Dead-Reckoning**: 2D Extended Kalman Filter in Dart for smooth navigation in tunnels and GPS blackouts.
- **Networking**: Binary Protobuf WebSocket deltas cutting telemetry bandwidth by 74%.
- **Backend**: Go WebSocket engine with Redis Geo indexing.

## Running Tests

```bash
# Unit & Widget tests
flutter test

# Integration test
flutter test integration_test/dispatch_tracking_test.dart
```

## Building Native Release APK

```bash
flutter pub get
flutter build apk --release
```
