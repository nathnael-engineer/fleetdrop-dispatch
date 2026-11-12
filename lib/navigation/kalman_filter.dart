import 'dart:math' as math;

class GpsMeasurement {
  final double lat;
  final double lng;
  final double accuracyMeters;
  final int timestampMs;

  GpsMeasurement({
    required this.lat,
    required this.lng,
    required this.accuracyMeters,
    required this.timestampMs,
  });
}

class GpsKalmanFilter {
  final double processNoise;
  double _lat = 0.0;
  double _lng = 0.0;
  double _velocityLat = 0.0;
  double _velocityLng = 0.0;
  double _variance = -1.0;
  int _lastTimestampMs = 0;

  GpsKalmanFilter({this.processNoise = 3.0});

  Map<String, double> update(GpsMeasurement measurement) {
    final accuracy = math.max(measurement.accuracyMeters, 1.0);

    if (_variance < 0) {
      _lat = measurement.lat;
      _lng = measurement.lng;
      _variance = accuracy * accuracy;
      _lastTimestampMs = measurement.timestampMs;
      return {'lat': _lat, 'lng': _lng};
    }

    final dt = math.max((measurement.timestampMs - _lastTimestampMs) / 1000.0, 0.001);
    _lastTimestampMs = measurement.timestampMs;

    _lat += _velocityLat * dt;
    _lng += _velocityLng * dt;
    _variance += processNoise * dt;

    final kalmanGain = _variance / (_variance + accuracy * accuracy);
    final deltaLat = measurement.lat - _lat;
    final deltaLng = measurement.lng - _lng;

    _lat += kalmanGain * deltaLat;
    _lng += kalmanGain * deltaLng;
    _velocityLat = deltaLat / dt;
    _velocityLng = deltaLng / dt;
    _variance = (1.0 - kalmanGain) * _variance;

    return {'lat': _lat, 'lng': _lng, 'variance': _variance};
  }
}