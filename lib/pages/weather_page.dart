import "dart:ffi";

import "package:flutter/material.dart";
import "package:new_flutter/api/weather_api.dart";
import "package:new_flutter/component/city_name_container.dart";
import "package:new_flutter/component/days_container.dart";
import "package:new_flutter/component/feels_like.dart";
import "package:new_flutter/component/circle_level.dart";
import "package:new_flutter/component/search_bar.dart";
import "package:new_flutter/component/sunrise.dart";
import "package:new_flutter/component/wind.dart";
import "package:new_flutter/models/weather_model.dart";

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherApi = WeatherApi("47300a7cc39d22ffed4cc133ea3d36b4");
  Weather? _weather;

  _fetchWeather([String? cityName]) async {
    cityName ??= await _weatherApi.getCurrentLocation();
    print(cityName);
    try {
      final weather = await _weatherApi.fetchWeather(cityName);
      print(weather.icon);
      print(weather.theme);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print("Error fetching weather: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: (_weather?.theme == "dark" ? Color.fromARGB(255, 12, 55, 90) : Colors.blue[100]),
        appBar: AppBar(
          backgroundColor: (_weather?.theme == "dark" ? Color.fromARGB(255, 12, 55, 90) : Colors.blue[100]),
          title: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                spacing: 20,
                children: [
                  Image.asset(_weather?.icon ?? 'assets/icons/empty.png', width: 50),
                  Text(
                    "Weather App",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ],
              )),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
          child: Column(
            spacing: 20,
            children: [
              CustomSearchBar(
                onSearch: (cityName) {
                  _fetchWeather(cityName);
                },
              ),
              CityNameContainer(weather: _weather),
              FeelsLike(weather: _weather),
              WindComponent(
                windSpeed: _weather?.windSpeed ?? 0,
                windDirection: _weather?.windDirection ?? 0,
                weatherTheme: _weather?.theme,
              ),
              Column(
                spacing: 20,
                children: [
                  Text("Clouds",
                      style: TextStyle(fontSize: 20, color:(_weather?.theme == "dark" ? Colors.white : Colors.black), fontWeight: FontWeight.bold)),
                  CircleLevel(
                    percentage: (_weather?.clouds ?? 0)
                        .toDouble(),
                    size: 150,
                    backgroundColor: Colors.grey[300]!,
                    progressColor: Colors.blue,
                    textStyle: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: (_weather?.theme == "dark" ? Colors.white : Colors.black)),
                  ),
                ],
              ),
              Column(
                spacing: 20,
                children: [
                  Text("Humidity",
                      style: TextStyle(fontSize: 20, color: (_weather?.theme == "dark" ? Colors.white : Colors.black), fontWeight: FontWeight.bold)),
                  CircleLevel(
                    percentage: (_weather?.humidity ?? 0)
                        .toDouble(),
                    size: 150,
                    backgroundColor: Colors.grey[300]!,
                    progressColor: Colors.blue,
                    textStyle: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: (_weather?.theme == "dark" ? Colors.white : Colors.black)),
                  ),
                ],
              ),
              /* SunriseToSunset(
                  sunrise: _weather?.sunrise ?? 0,
                  sunset: _weather?.sunset ?? 0, timezone: _weather?.timezone ?? 0), */
            ],
          ),
        ),
      ),
    );
  }
}
