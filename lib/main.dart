import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  final GlobalKey<_WidgetIndicatorState> _widgetIndicatorKey =
      GlobalKey<_WidgetIndicatorState>();

  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.indigoAccent,
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: const Text('Progress Indicator',
              style: TextStyle(color: Colors.white)),
        ),
        body: Center(
          child: WidgetIndicator(key: _widgetIndicatorKey),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _widgetIndicatorKey.currentState?.startLoading();
          },
          backgroundColor: Colors.white,
          shape: const CircleBorder(),
          child: const Icon(Icons.start),
        ),
      ),
    );
  }
}

class WidgetIndicator extends StatefulWidget {
  const WidgetIndicator({super.key});

  @override
  State<WidgetIndicator> createState() => _WidgetIndicatorState();
}

class _WidgetIndicatorState extends State<WidgetIndicator> {
  bool _isLoading = false;
  double _progress = 0;

  @override
  void initState() {
    _isLoading = false;
    _progress = 0;
    super.initState();
  }

  void startLoading() {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
        _progress = 0;
      });

      Timer.periodic(const Duration(milliseconds: 100), (timer) {
        if (_progress >= 1) {
          timer.cancel();
          setState(() {
            _isLoading = false;
          });
        } else {
          setState(() {
            _progress += 0.05;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: _isLoading
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LinearProgressIndicator(
                  value: _progress,
                ),
                const SizedBox(height: 8),
                Text('Loading ${(100 * _progress).round()}%'),
              ],
            )
          : const Text('Press the button to start loading',
              style: TextStyle(color: Colors.white)),
    );
  }
}
