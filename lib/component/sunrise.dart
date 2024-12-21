import 'package:flutter/material.dart';
import 'dart:async';

class SunriseToSunset extends StatefulWidget {
  final int sunrise;
  final int sunset;
  final int timezone;

  const SunriseToSunset({
    super.key,
    required this.sunrise,
    required this.sunset,
    required this.timezone,
  });

  @override
  State<SunriseToSunset> createState() => _SunriseToSunsetState();
}

class _SunriseToSunsetState extends State<SunriseToSunset> {
  late double _progress;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _updateProgress();
    _timer = Timer.periodic(const Duration(seconds: 60), (timer) {
      _updateProgress();
    });
  }

  void _updateProgress() {
    final currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    if (currentTime < widget.sunrise) {
      _progress = 0.0;
    } else if (currentTime > widget.sunset) {
      _progress = 1.0;
    } else {
      _progress = (currentTime - widget.sunrise) / (widget.sunset - widget.sunrise);
    }
    setState(() {});
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            "Sunrise to Sunset",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        Row(
          children: [
            Text(
              _formatTime(widget.sunrise, widget.timezone),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.centerLeft,
                clipBehavior: Clip.none,
                children: [
                  LinearProgressIndicator(
                    value: _progress,
                    backgroundColor: Colors.orange[100],
                    color: Colors.orange,
                    minHeight: 6,
                  ),
                  Positioned(
                    left: _progress * MediaQuery.of(context).size.width,
                    child: Icon(Icons.wb_sunny, color: Colors.orange),
                  ),
                ],
              ),
            ),
            Text(
              _formatTime(widget.sunset, widget.timezone),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }

  String _formatTime(int timestamp, int timezoneOffset) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(
        (timestamp + timezoneOffset) * 1000);
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }
}
