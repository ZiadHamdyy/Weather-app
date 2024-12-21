import 'package:flutter/material.dart';

class WindComponent extends StatelessWidget {
  final double windSpeed; // Speed in km/h or mph
  final double windDirection; // Direction in degrees (0-360)
  final String? weatherTheme; // Direction in degrees (0-360)

  const WindComponent({
    super.key,
    required this.windSpeed,
    required this.windDirection,
    required this.weatherTheme,
  });

  String _convertDegreesToDirection(double degrees) {
    if (degrees >= 337.5 || degrees < 22.5) return 'N';
    if (degrees >= 22.5 && degrees < 67.5) return 'NE';
    if (degrees >= 67.5 && degrees < 112.5) return 'E';
    if (degrees >= 112.5 && degrees < 157.5) return 'SE';
    if (degrees >= 157.5 && degrees < 202.5) return 'S';
    if (degrees >= 202.5 && degrees < 247.5) return 'SW';
    if (degrees >= 247.5 && degrees < 292.5) return 'W';
    if (degrees >= 292.5 && degrees < 337.5) return 'NW';
    return 'Unknown';
  }

  @override
  Widget build(BuildContext context) {
    String direction = _convertDegreesToDirection(windDirection);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Wind",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: (weatherTheme == "dark" ? Colors.white : Colors.black)),
        ),
        const SizedBox(height: 10),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.blue[50],
                shape: BoxShape.circle,
              ),
            ),
            Transform.rotate(
              angle: windDirection * (3.141592653589793 / 180), // Degrees to radians
              child: Icon(
                Icons.navigation, // Upward arrow icon
                size: 40,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          "Speed: ${windSpeed.toStringAsFixed(1)} km/h",
          style: TextStyle(fontSize: 16, color: (weatherTheme == "dark" ? Colors.white : Colors.black87)),
        ),
        Text(
          "Direction: $direction",
          style: TextStyle(fontSize: 16, color: (weatherTheme == "dark" ? Colors.white : Colors.black87)),
        ),
      ],
    );
  }
}
