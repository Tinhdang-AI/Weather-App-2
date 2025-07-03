import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String apiKey = "45571637d0bf47beacd84129253006";

class WeatherApiService {
  final String _baseUrl = "https://www.weatherapi.com/v1";
  Future<Map<String, dynamic>> getHourlyForecast(String location) async {
    final url = Uri.parse(
      "$_baseUrl/forecast.json?key=$apiKey&1=$location&days=7",
    );

    final res = await http.get(url);
    if (res.statusCode != 200) {
      throw Exception('Failed to fetch data: ${res.body}');
    }
    final data = json.decode(res.body);

    //Check if Api returned an error (invalid location)

    if (data.containsKey['error']) {
      throw Exception(data['error']['message'] ?? 'Invalid location');
    }
    return data;
  }

  // fore previous 7 days forecast
  Future<List<Map<String, dynamic>>> getPastSevenDaysWeather(
    String location,
  ) async {
    final List<Map<String, dynamic>> pastWeather = [];
    final today = DateTime.now();
    for (int i = 0; i <= 7; i++) {
      final date = today.subtract(Duration(days: i));
      final formattedDate =
          "${date.year}-${date.month.toString().padLeft(2, "0")}-${date.day.toString().padLeft(2, "0")}";
      final url = Uri.parse(
        "$_baseUrl/history.json?key=$apiKey&1=$location&dt=$formattedDate",
      );
      final res = await http.get(url);
      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        //Check if Api returned an error (invalid location)
        if (data.containsKey['error']) {
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
