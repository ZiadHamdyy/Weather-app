import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final String weatherDescription;
  final int humidity;
  final int clouds;
  final double feelsLike;
  final int sunrise;
  final int sunset;
  final double windSpeed;
  final double windDirection;
  final String theme;
  final String icon;
  final String day;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.day,
    required this.weatherDescription,
    required this.humidity,
    required this.clouds,
    required this.feelsLike,
    required this.sunrise,
    required this.sunset,
    required this.windSpeed,
    required this.windDirection,
    required this.theme,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
      day: dayOfWeek(json['dt'], json['timezone']),
      weatherDescription: json['weather'][0]['description'],
      humidity: json['main']['humidity'],
      clouds: json['clouds']['all'],
      feelsLike: json['main']['feels_like'].toDouble(),
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      windSpeed: json['wind']['speed'].toDouble(),
      windDirection: json['wind']['deg'].toDouble(),
      theme: Theme(json['dt'], json['sys']['sunrise'], json['sys']['sunset'], json['timezone']),
      icon: Icon(json['weather'][0]['icon'], Theme(json['dt'], json['sys']['sunrise'], json['sys']['sunset'], json['timezone'])),
    );
  }
  static String dayOfWeek(int timestamp, int timezoneOffset) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
        (timestamp + timezoneOffset) * 1000);

    String dayName = DateFormat('EEEE').format(dateTime);

    String formattedDate = DateFormat('MMMM d, yyyy').format(dateTime);

    return '$dayName $dateTime $formattedDate';
  }

  static String Theme(
      int timestamp, int sunrise, int sunset, int timezoneOffset) {
    // Convert timestamp to local time using timezone offset
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
        (timestamp + timezoneOffset) * 1000);

    // Convert sunrise and sunset times to local time using timezone offset
    DateTime localSunrise =
        DateTime.fromMillisecondsSinceEpoch((sunrise + timezoneOffset) * 1000);
    DateTime localSunset =
        DateTime.fromMillisecondsSinceEpoch((sunset + timezoneOffset) * 1000);

    // Determine if it's dark or light
    if (dateTime.isBefore(localSunrise) || dateTime.isAfter(localSunset)) {
      return 'dark';
    } else {
      return 'light';
    }
  }

  static String Icon(String icon, String theme) {
    if (icon == "01d") {
      return 'assets/icons/contrast.png';
    } else if (icon == "01n" && theme == "dark") {
      return 'assets/icons/moon.png';
    } else if (icon == "02d" || icon == "03d") {
      return 'assets/icons/sun_cloudy.png';
    } else if (icon == "02n" && theme == "dark" ||
        icon == "03n" && theme == "dark") {
      return 'assets/icons/moon_cloudy.png';
    } else if (icon == "04d" || icon == "04n" && theme == "dark") {
      return 'assets/icons/cloud.png';
    } else if (icon == "09d" ||
        icon == "09n" && theme == "dark" ||
        icon == "10d" ||
        icon == "10n" && theme == "dark") {
      return 'assets/icons/heavy-rain.png';
    } else if (icon == "11d" || icon == "11n" && theme == "dark") {
      return 'assets/icons/storm.png';
    } else if (icon == "13d" || icon == "13n" && theme == "dark") {
      return 'assets/icons/snow.png';
    } else {
      return 'assets/icons/empty.png';
    }
  }
}
