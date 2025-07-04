import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String apiKey = "45571637d0bf47beacd84129253006";

class WeatherApiService {
  final String _baseUrl = "https://api.weatherapi.com/v1";

  /// Gets hourly forecast for 7 days for a given location
  Future<Map<String, dynamic>> getHourlyForecast(String location) async {
    final url = Uri.parse(
      "$_baseUrl/forecast.json?key=$apiKey&q=$location&days=7&aqi=no&alerts=no",
    );

    final res = await http.get(url);

    if (res.statusCode != 200) {
      throw Exception('Failed to fetch data: ${res.body}');
    }

    final data = json.decode(res.body);

    // Check if API returned an error (e.g. invalid location)
    if (data.containsKey('error')) {
      throw Exception(data['error']['message'] ?? 'Invalid location');
    }

    return data;
  }

  /// Gets weather history for the past 7 days for a given location
  Future<List<Map<String, dynamic>>> getPastSevenDaysWeather(String location) async {
    final List<Map<String, dynamic>> pastWeather = [];
    final today = DateTime.now();

    for (int i = 0; i < 7; i++) {
      final date = today.subtract(Duration(days: i));
      final formattedDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

      final url = Uri.parse(
        "$_baseUrl/history.json?key=$apiKey&q=$location&dt=$formattedDate",
      );

      final res = await http.get(url);

      if (res.statusCode == 200) {
        final data = json.decode(res.body);

        if (data.containsKey('error')) {
          throw Exception(data['error']['message'] ?? 'Invalid location');
        }

        if (data['forecast']?['forecastday'] != null) {
          pastWeather.add(data);
        }
      } else {
        debugPrint('Failed to fetch past data for $formattedDate: ${res.body}');
      }
    }

    return pastWeather;
  }
}
