import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MaceGameScreen(),
    );
  }
}

class MaceGameScreen extends StatefulWidget {
  const MaceGameScreen({super.key});

  @override
  State<MaceGameScreen> createState() => _MaceGameScreenState();
}

class _MaceGameScreenState extends State<MaceGameScreen> {
  late UnityWidgetController unityController;
  StreamSubscription? accelSubscription;

  @override
  void initState() {
    super.initState();
    startIphoneTracking();
  }

  void startIphoneTracking() {
    accelSubscription = accelerometerEvents.listen((AccelerometerEvent event) {
      unityController.postMessage(
        'Stick',                    // Name of your Stick GameObject in Unity
        'ReceiveMotionData',
        '${event.x},${event.y},${event.z}',
      );
    });
  }

  @override
  void dispose() {
    accelSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UnityWidget(
        onUnityCreated: (controller) {
          unityController = controller;
        },
      ),
    );
  }
}