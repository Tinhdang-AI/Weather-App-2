import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeeklyForecast extends StatefulWidget {
  final String city;
  final List<dynamic> pastWeek;
  final List<dynamic> next7days;
  final Map<String, dynamic> currentValue;

  const WeeklyForecast({
    super.key,
    required this.city,
    required this.pastWeek,
    required this.next7days,
    required this.currentValue,
  });

  @override
  State<WeeklyForecast> createState() => _WeeklyForecastState();
}

class _WeeklyForecastState extends State<WeeklyForecast> {
  String formatApiData(String dataString) {
    DateTime date = DateTime.parse(dataString);
    return DateFormat('d MMMM, EEEE').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final condition = widget.currentValue['condition'] ?? {};
    final iconUrl =
        condition['icon'] != null ? "https:${condition['icon']}" : "";

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      widget.city,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    Text(
                      "${widget.currentValue['temp_c']}°C",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    Text(
                      "${condition['text'] ?? ''}",
                      style: TextStyle(
                        fontSize: 22,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    if (iconUrl.isNotEmpty)
                      Image.network(
                        iconUrl,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                  ],
                ),
              ),

              // TODO: Add widgets to display widget.pastWeek and widget.next7days
              const SizedBox(height: 20),
              Text(
                "Next 7 Days Forecast",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const SizedBox(height: 10),
              ...widget.next7days.map((day) {
                final date = day['date'] ?? "";
                final condition = day['day']?['condition']?['text'] ?? '';
                final icon = day['day']?['condition']?['icon'] ?? '';
                final maxTemp = day['day']?['maxtemp_c'];
                final minTemp = day['day']?['mintemp_c'];

                return ListTile(
                  leading: Image.network("https:$icon", width: 40),
                  title: Text(
                    formatApiData(date),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  subtitle: Text(
                    "$condition $minTemp°C - $maxTemp°C",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                );
              }),
              const SizedBox(height: 20),
              Text(
                "Previous 7 Days Forecast",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const SizedBox(height: 10),
              ...widget.pastWeek.map((day) {
                final forecastDay = day['forecast']?['forecastday'];
                // Return empty container if no data
                if (forecastDay == null || forecastDay.isEmpty) {
                  return SizedBox.shrink();
                }

                final forecast = forecastDay[0];
                final date = forecast['date'] ?? "";
                final condition = forecast['day']?['condition']?['text'] ?? '';
                final icon = forecast['day']?['condition']?['icon'] ?? '';
                final maxTemp = forecast['day']?['maxtemp_c'];
                final minTemp = forecast['day']?['mintemp_c'];

                return ListTile(
                  leading: Image.network("https:$icon", width: 40),
                  title: Text(
                    formatApiData(date),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  subtitle: Text(
                    "$condition $minTemp°C - $maxTemp°C",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
