import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weatherforecast/weather.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

//Burayı ben taşıdım buraya
//1- bu veri çekme kısmını widget içinde yapma  dışarıda kalsın
Weatherforecast parseWeather(String response) {
  return Weatherforecast.fromJson(json.decode(response));
}

Future<Weatherforecast> getWeather() async {
  var url = Uri.parse(
      "https://api.collectapi.com/weather/getWeather?data.lang=tr&data.city=ankara");

  var cvp = await http.get(url, headers: {
    "content-type": "application/json",
    "authorization": "apikey 05oXKaSRCp9lzFMT9YYpX3:0qyoMZ5AbY90Id8AtscsU2"
  });
  print(cvp.body);
  return parseWeather(cvp.body);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.blue,
            title: const Center(
              child: Text(
                "Hava Durumu",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          backgroundColor: Colors.blue,
          body: MyWidget()),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getWeather(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var weatherData = snapshot.data!.result;
          return GridView.builder(
              itemCount: weatherData.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5, childAspectRatio: 0.5),
              itemBuilder: (context, index) {
                var havaDurumu = weatherData[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.network(
                              havaDurumu.icon,
                            ),
                          ),
                          Text(
                            havaDurumu.date,
                            textAlign: TextAlign.end,
                            // ignore: prefer_const_constructors
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.red),
                          ),
                          Text(havaDurumu.day,
                              // ignore: prefer_const_constructors
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.red)),
                          Text(havaDurumu.degree,
                              // ignore: prefer_const_constructors
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.red)),
                          Text(havaDurumu.description,
                              textAlign: TextAlign.center,
                              // ignore: prefer_const_constructors
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.red)),
                          Text(
                            "${((double.parse(havaDurumu.humidity) - 32) / 1.8).toStringAsFixed(2)}°C",
                            // ignore: prefer_const_constructors
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.red),
                          ),
                          Text(havaDurumu.max,
                              // ignore: prefer_const_constructors
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.red)),
                          Text(havaDurumu.min,
                              // ignore: prefer_const_constructors
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.red)),
                          Text(havaDurumu.night,
                              // ignore: prefer_const_constructors
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.red)),
                        ],
                      )),
                );
              });
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
