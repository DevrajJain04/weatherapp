import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/additional_info_item.dart';
import 'package:weatherapp/hourly_forecast_item.dart';
import 'package:weatherapp/secrets.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/view_pages/weather_cityname.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => WeatherScreenState();
}

class WeatherScreenState extends State<WeatherScreen> {
  late Future<Map<String, dynamic>> weather;
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = CityNameState.ucityName;
      final res = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIKey'),
      );

      final data = jsonDecode(res.body);
      if (data['cod'] != '200') {
        throw 'an unexpected error occurred';
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    weather = getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          
        ),
        centerTitle: true,
        actions: [
          InkWell(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  weather = getCurrentWeather();
                });
              },
              child: const Icon(Icons.refresh),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: weather,
        builder: (context, snapshot) {
          //print(snapshot);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          final data = snapshot.data!;
          final currentWeatherData = data['list'][0];
          final currentTemp = currentWeatherData['main']['temp'];
          final currentSky = currentWeatherData['weather'][0]['main'];
          final currentPressure = currentWeatherData['main']['pressure'];
          final currentWindSpeed = currentWeatherData['wind']['speed'];
          final currentHumidity = currentWeatherData['main']['humidity'];
          final currentSealevel = currentWeatherData['main']['sea_level'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //main card
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                '$currentTemp K',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16),
                              Icon(
                                currentSky == 'Cloud' || currentSky == 'Rain'
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 64,
                              ),
                              SizedBox(height: 16),
                              Text(
                                currentSky,
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ), //gap between the 2 placeholders
                //weatherforecast card
                const Text(
                  'Hourly Forecast',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       for (int i = 0; i < 5; i++)
                //         HourlyForecastItem(
                //           time: data['list'][i + 1]['dt'].toString(),
                //           temparature:
                //               data['list'][i + 1]['main']['temp'].toString(),
                //           icon: data['list'][i + 1]['weather'][0]['main'] ==
                //                       'Clouds' ||
                //                   data['list'][i + 1]['weather'][0]['main'] ==
                //                       'Rain'
                //               ? Icons.cloud
                //               : Icons.sunny,
                //         ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final hourlyForecastItem = data['list'][index + 1];
                      final hourlySky =
                          data['list'][index + 1]['weather'][0]['main'];
                      final hourlyTemp = hourlyForecastItem['main']['temp'];
                      final time = DateTime.parse(hourlyForecastItem['dt_txt']);
                      return HourlyForecastItem(
                        time: DateFormat.Hm().format(time),
                        temparature: hourlyTemp.toString(),
                        icon: hourlySky == 'Clouds' || hourlySky == 'Rain'
                            ? Icons.cloud
                            : Icons.sunny,
                      );
                    },
                  ),
                ),
                //additional info
                const SizedBox(height: 20),
                const Text(
                  'Additional Info',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInfoItem(
                      icon: Icons.water_drop,
                      label: 'Humidity',
                      value: currentHumidity.toString(),
                    ),
                    AdditionalInfoItem(
                      icon: Icons.air,
                      label: 'Wind speed',
                      value: currentWindSpeed.toString(),
                    ),
                    AdditionalInfoItem(
                      icon: Icons.beach_access,
                      label: 'pressure',
                      value: currentPressure.toString(),
                    ),
                    AdditionalInfoItem(
                      icon: Icons.waves_rounded,
                      label: 'Sea Level',
                      value: currentSealevel.toString(),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  // void wheretogo() async {
  //   var citydata = await SharedPreferences.getInstance();
  //   citydata.getBool('city');
  // }
}
