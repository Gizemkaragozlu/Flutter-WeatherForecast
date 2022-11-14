// To parse this JSON data, do
//
//     final weatherforecast = weatherforecastFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Weatherforecast weatherforecastFromJson(String str) =>
    Weatherforecast.fromJson(json.decode(str));

String weatherforecastToJson(Weatherforecast data) =>
    json.encode(data.toJson());

class Weatherforecast {
  Weatherforecast({
    required this.success,
    required this.city,
    required this.result,
  });

  final bool success;
  final String city;
  final List<Result> result;

  factory Weatherforecast.fromJson(Map<String, dynamic> json) =>
      Weatherforecast(
        success: json["success"],
        city: json["city"],
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "city": city,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    required this.date,
    required this.day,
    required this.icon,
    required this.description,
    required this.status,
    required this.degree,
    required this.min,
    required this.max,
    required this.night,
    required this.humidity,
  });

  final String date;
  final String day;
  final String icon;
  final String description;
  final String status;
  final String degree;
  final String min;
  final String max;
  final String night;
  final String humidity;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        date: json["date"],
        day: json["day"],
        icon: json["icon"],
        description: json["description"],
        status: json["status"],
        degree: json["degree"],
        min: json["min"],
        max: json["max"],
        night: json["night"],
        humidity: json["humidity"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "day": day,
        "icon": icon,
        "description": description,
        "status": status,
        "degree": degree,
        "min": min,
        "max": max,
        "night": night,
        "humidity": humidity,
      };
}
