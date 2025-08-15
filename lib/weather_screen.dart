import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'apikeysofwether.dart';
import 'hourly_forecast_item.dart';
import 'package:intl/intl.dart';


import 'additional_info_item.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {


  Future<Map<String,dynamic>> getCurrentWeather() async {
    try {
      String cityName = 'Durgapur';
      final result = await http.get(
        Uri.parse(
            'http://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherapikey'
        ),
      );
      final data = jsonDecode(result.body);
      if(data['cod'] != '200'){
        throw data['message'];
      }

      return data;
     //
    } catch (e) {
      throw e.toString();
    }


  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Weather App',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        ),
        centerTitle: true,
        actions: [IconButton(onPressed: (){setState(() {

        });}, icon: const Icon(Icons.refresh))
        ],
      ), // app bar finish now design card or main card
      body: FutureBuilder(
        future:getCurrentWeather() ,
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator.adaptive());
          }
          if(snapshots.hasError){
            return Center(child: Text(snapshots.error.toString()));
          }
          final data = snapshots.data!;
          final datagram = data['list'][0]['main']['temp'] - 273.15;
          final currentTemp = double.parse(datagram.toStringAsFixed(2));
          final currentSky = data['list'][0]['weather'][0]['main'];
          final currentPressure = data['list'][0]['main']['pressure'];
          final currentWindSpeed = data['list'][0]['wind']['speed'];
          final currentHumidity = data['list'][0]['main']['humidity'];
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column( // column for layout of card i am gonna put all three things in this as linear layout in android
                crossAxisAlignment: CrossAxisAlignment.start,
                // start every thing in horizontal at start to left extreme in place of center
                children: [
                  // i am gonnna put all boxes or card in this in manner i want to show them like main card->wether forecast card -> additonal information card
                  // main card
                  Container(
                    width: double.infinity,
                    child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Text('$currentTemp°C', style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32,
                                  ),
                                  ),
                                  const SizedBox(height: 16),
                                  Icon(currentSky == 'Clouds' || currentSky == 'Rain'? Icons.cloud:Icons.sunny,
                                    size: 64,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    currentSky ,
                                    style:const TextStyle(
                                    fontSize: 20,
                                  ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                    ),
                  ),
                  const SizedBox(height: 20),
                  // this is for gap btwn two cards (main card and forecast card)
                  //weather forecast card
                  Text('Hourly Forecast',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),      //gap btwn heading of weather forecast and card of next days

                  SizedBox(
                    height: 120,
                    child: Builder(
                      builder: (context) {
                        // Current UTC time
                        int timezoneOffset = data['city']['timezone'];
                        DateTime nowLocal = DateTime.now().toUtc().add(Duration(seconds: timezoneOffset));

                        // Find the index of the first forecast AFTER current time
                        int startIndex = data['list'].indexWhere((forecast) {
                          int timestampUtc = forecast['dt'];
                          DateTime forecastLocal = DateTime.fromMillisecondsSinceEpoch(
                            (timestampUtc + timezoneOffset) * 1000,
                            isUtc: true,
                          );
                          return forecastLocal.isAfter(nowLocal);
                        });

                        // Safety: if nothing found, default to 0
                        if (startIndex == -1) startIndex = 0;

                        return ListView.builder(
                          itemCount: 5, // 5 x 3-hour slots
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final hourlyForecast = data['list'][startIndex + index];
                            final hourlySky = hourlyForecast['weather'][0]['main'];
                            final hourlyTemp = (hourlyForecast['main']['temp'] - 273.15)
                                .toStringAsFixed(2);

                            // Convert timestamp to local time
                            int timestampUtc = hourlyForecast['dt'];
                            DateTime localTime = DateTime.fromMillisecondsSinceEpoch(
                              (timestampUtc + timezoneOffset) * 1000,
                              isUtc: true,
                            );

                            // Format time like 12 AM, 03 AM, 06 AM
                            String formattedTime = DateFormat('hh a').format(localTime);

                            return HourlyForecastItem(
                              icon: hourlySky == 'Clouds' || hourlySky == 'Rain'
                                  ? Icons.cloud
                                  : Icons.sunny,
                              time: formattedTime,
                              temp: hourlyTemp,
                            );
                          },
                        );
                      },
                    ),
                  ),

                const SizedBox(height: 20),
                  // gap btw forecast card and info card
                  // additional information card
                  Text('Additional Information',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AdditionalInfoItem(
                        icon: Icons.water_drop,
                        label: 'Humidity',
                        value: '$currentHumidity',
                      ),
                      AdditionalInfoItem(
                          icon: Icons.air,
                          label: 'Wind Speed',
                          value: '$currentWindSpeed'
                      ),
                      AdditionalInfoItem(
                        icon: Icons.beach_access,
                        label: 'Pressure',
                        value: '$currentPressure'),
                    ],
                  )
                ],
              ),
            );

        }
      ),

    );
  }
}
