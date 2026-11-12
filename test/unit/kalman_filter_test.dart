import 'package:flutter_test/flutter_test.dart';
import 'package:fleetdrop_dispatch/navigation/kalman_filter.dart';

void main() {
  group('GpsKalmanFilter Tests', () {
    test('Initializes state from first GPS fix', () {
      final filter = GpsKalmanFilter();
      final fix = GpsMeasurement(
        lat: 9.012345,
        lng: 38.761234,
        accuracyMeters: 5.0,
        timestampMs: 1000,
      );

      final state = filter.update(fix);
      expect(state['lat'], closeTo(9.012345, 0.000001));
      expect(state['lng'], closeTo(38.761234, 0.000001));
    });
  });
}