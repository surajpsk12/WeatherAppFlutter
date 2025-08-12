import 'dart:ui';

import 'package:flutter/material.dart';
import 'hourly_forecast_item.dart';

import 'additional_info_item.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

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
        actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.refresh))
        ],
      ), // app bar finish now design card or main card
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column( // column for layout of card i am gonna put all three things in this as linear layout in android
          crossAxisAlignment: CrossAxisAlignment.start, // start every thing in horizontal at start to left extreme in place of center
          children: [ // i am gonnna put all boxes or card in this in manner i want to show them like main card->wether forecast card -> additonal information card
            // main card
                Container(
                  width: double.infinity,
                  child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    child:ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                              children: [
                                Text('25°C',style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                ),
                                ),
                               SizedBox(height: 16),
                                Icon(Icons.cloud,
                                  size: 64,
                                ),
                                SizedBox(height: 16),
                                Text('Rain', style: TextStyle(
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
            const SizedBox(height: 20), // this is for gap btwn two cards (main card and forecast card)
            //weather forecast card
            Text('Weather Forecast',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              ) ,
            ),
            const SizedBox(height: 8), //gap btwn heading of weather forecast and card of next days
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  HourlyForecastItem(icon: Icons.sunny, time: '03:00', temp: '45'),
                  HourlyForecastItem(icon: Icons.cloud,time:'06:00',temp:'24'),
                  HourlyForecastItem(icon: Icons.sunny,time:'09:00',temp:'33'),
                  HourlyForecastItem(icon: Icons.cloud,time:'12:00',temp:'21'),
                  HourlyForecastItem(icon: Icons.snowing,time:'15:00',temp:'05'),
                ],
              ),
            ),

            const SizedBox(height: 20), // gap btw forecast card and info card
            // additional information card
            Text('Additional Information',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ) ,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AdditionalInfoItem(
                  icon: Icons.water_drop,
                  label: 'Humidity',
                  value: '91',
                ),
                AdditionalInfoItem(
                  icon: Icons.air,
                  label: 'Wind Speed',
                  value: '7.5'
                ),
                AdditionalInfoItem(
                  icon: Icons.beach_access,
                  label: 'Pressure',
                  value: '1000',),
              ],
            )
          ],
        ),
      ),

    );
  }
}
