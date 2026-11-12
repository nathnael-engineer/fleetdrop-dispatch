import 'package:flutter/material.dart';
import 'navigation/kalman_filter.dart';

void main() {
  runApp(const FleetDropApp());
}

class FleetDropApp extends StatelessWidget {
  const FleetDropApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FleetDrop Dispatch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF09090B),
      ),
      home: const DispatchScreen(),
    );
  }
}

class DispatchScreen extends StatefulWidget {
  const DispatchScreen({super.key});

  @override
  State<DispatchScreen> createState() => _DispatchScreenState();
}

class _DispatchScreenState extends State<DispatchScreen> {
  final GpsKalmanFilter _filter = GpsKalmanFilter();
  double _lat = 9.0123;
  double _lng = 38.7612;

  void _simulateGpsTick() {
    final updated = _filter.update(GpsMeasurement(
      lat: _lat + 0.0005,
      lng: _lng + 0.0003,
      accuracyMeters: 4.5,
      timestampMs: DateTime.now().millisecondsSinceEpoch,
    ));
    setState(() {
      _lat = updated['lat']!;
      _lng = updated['lng']!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FleetDrop Dispatch', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF09090B),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('ACTIVE ROUTE: KALMAN FILTER ENGAGED', style: TextStyle(color: Color(0xFF10B981), fontSize: 12, letterSpacing: 1.2)),
              const SizedBox(height: 12),
              Text('Lat: ${_lat.toStringAsFixed(5)}', style: const TextStyle(fontSize: 18, fontFamily: 'monospace')),
              Text('Lng: ${_lng.toStringAsFixed(5)}', style: const TextStyle(fontSize: 18, fontFamily: 'monospace')),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _simulateGpsTick,
                icon: const Icon(Icons.navigation, color: Colors.black),
                label: const Text('Simulate Vehicle Heading'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}