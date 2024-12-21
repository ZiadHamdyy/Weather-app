
import "dart:convert";
import "package:geocoding/geocoding.dart";
import "package:geolocator/geolocator.dart";
import 'package:new_flutter/models/weather_model.dart';
import "package:http/http.dart" as http;
class WeatherApi {
  static const baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherApi(this.apiKey);
  Future<Weather> fetchWeather(String cityName) async {
    final response = await http.get(
      Uri.parse('$baseUrl?q=$cityName&appid=$apiKey&units=metric'),
    );
      print(response.statusCode);
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<String> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemark = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    String? cityName = placemark[0].administrativeArea?.split(" ")[0];
    return cityName ?? "cairo";
  }
}