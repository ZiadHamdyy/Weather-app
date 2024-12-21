import 'package:flutter/material.dart';
import 'package:new_flutter/api/weather_api.dart';
import 'package:new_flutter/models/weather_model.dart';

class CityNameContainer extends StatelessWidget {
  final Weather? weather;
  const CityNameContainer({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      width: MediaQuery.of(context).size.width * 0.8,
      margin: EdgeInsets.symmetric(vertical: 30),
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: (weather?.theme == "dark" ? Colors.blue[900] : Colors.blue),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          /* BoxShadow(
            color: Colors.grey,
            blurRadius: 10,
            spreadRadius: 5,
            offset: Offset(0, 5),
          ), */
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            weather?.day.split(" ")[0] ?? '',
            style: TextStyle(fontSize: 20, color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            weather?.day.split(" ")[1] ?? '',
            style: TextStyle(fontSize: 20, color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            weather?.day.split(" ")[2].split(".")[0] ?? '',
            style: TextStyle(fontSize: 20, color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
          Flexible(
            child: Image.asset(weather?.icon ?? 'assets/icons/empty.png', width: 60),
          ),
          Text(
            weather?.cityName ?? '',
            style: TextStyle(fontSize: 30, color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "${weather?.temperature ?? ""}°C",
            style: TextStyle(fontSize: 50, color: Colors.white),
          ),
          Text(
            "${weather?.weatherDescription ?? ""}",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ],
      ),
    );
  }
}