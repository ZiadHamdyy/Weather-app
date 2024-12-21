import 'package:flutter/material.dart';
import 'package:new_flutter/models/weather_model.dart';

class FeelsLike extends StatelessWidget {
  final Weather? weather;
  const FeelsLike({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.8,
      margin: EdgeInsets.symmetric(vertical: 30),
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: (weather?.theme == "dark" ? Colors.blue[900] : Colors.blue),
        borderRadius: BorderRadius.circular(20),
        /* boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10,
            spreadRadius: 5,
            offset: Offset(0, 5),
          ),
        ], */
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Feels Like",
            style: TextStyle(fontSize: 20, color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "${weather?.feelsLike ?? ""}°C",
            style: TextStyle(fontSize: 40, color: Colors.white),
          ),
        ],
      ),
    );
  }
}