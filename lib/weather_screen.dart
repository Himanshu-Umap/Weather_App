import 'dart:convert';
// import 'dart:html';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/additional_info_item.dart';
import 'package:weather_app/hourly_forecast_item.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/secreats.dart';
import 'package:weather_app/theme_weather_app.dart';


class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override 
  State<WeatherScreen> createState() => _WeatherScreenState();

}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Map<String,dynamic>> weather;

  @override
  void initState(){
    super.initState();
    weather = getCurrentWeather();
  }

  Future<Map<String,dynamic>> getCurrentWeather() async{
    try{  
      String cityName = 'Amravati';
      final result = await http.get(
        Uri.parse('https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWhetherAPIKey'),
    );

    final data = jsonDecode(result.body);

    if (data['cod'] != '200'){
      throw 'An unexpected error Occured';
    }

    return data;
    //
    }catch(e){
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    // getCurrentWeather();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        shadowColor: Colors.grey,
        actions: [
          /// wrap onTap widget with Gesture Detector or InkWell or use IconButton
          IconButton(
            onPressed: () {
              setState(() {
                weather = getCurrentWeather();
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: weather,
        builder: (content, snapshot) {
          // print(snapshot);
          // print(snapshot.runtimeType);
          if (snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (snapshot.hasError){
            return Center(
              child: Text(snapshot.error.toString())
              );
          }

          final data = snapshot.data!;

          final currentWeatherData = data['list'][0];

          final currentTemp = currentWeatherData['main']['temp'];
          final currentSky = currentWeatherData['weather'][0]['main'];
          final currentPressure = currentWeatherData['main']['pressure'];
          final currentWindSpeed = currentWeatherData['wind']['speed'];
          final currentHumidity = currentWeatherData['main']['humidity'];
          

          return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              /// Main Card
              SizedBox(
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 13,
                  color: Colors.blueAccent,
                  shadowColor: Colors.blue,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              '$currentTemp K',
                              style: const TextStyle(
                              fontWeight:FontWeight.bold,
                              fontSize: 32,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Icon(
                              currentSky == 'Clouds'|| currentSky == 'Rain' 
                              ? Icons.cloud 
                              : Icons.sunny,
                              size: 64,
                              ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '$currentSky',style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              /// Weather Forecast Card
              
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Weather/Hourly Forecast', 
                  textAlign: TextAlign.start, 
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),

              const SizedBox(
                height:15,
              ),
              
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     children: [
              //       for(int i = 0; i < 38; i++)
              //         HourlyForecastItem(
              //           time: data['list'][i + 1]['dt'].toString(), 
              //           icon: data['list'][i + 1]['weather'][0]['main'] == 'Clouds' ? Icons.cloud : data['list'][i + 1]['weather'][0]['main'] == 'Rain' ? Icons.water_drop : Icons.sunny,
              //           text: data['list'][i + 1]['main']['temp'].toString(),
              //           ),
                    
              //     ],
              //   ),
              // ),
              

              SizedBox(
                height: 120,
                child: ListView.builder(
                  itemCount: 39,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (content, index){
                    final time = DateTime.parse(data['list'][index + 1]['dt_txt']);
                    return HourlyForecastItem(
                      time: DateFormat.j().format(time), 
                      icon: data['list'][index + 1]['weather'][0]['main'] == 'Clouds' ? Icons.cloud : data['list'][index + 1]['weather'][0]['main'] == 'Rain' ? Icons.water_drop : Icons.sunny, 
                      text: data['list'][index + 1]['main']['temp'].toString(),
                    );
                  },
                ),
              ),


              const SizedBox(
                height: 20,
              ),
        
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Additional Information....',
                  textAlign: TextAlign.start, 
                  style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  ),
                ),
              ),
        
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AdditionalInfoItem(icon: Icons.water_drop, label: 'Humidity', value: '$currentHumidity'),
                  AdditionalInfoItem(icon: Icons.air, label: 'Wind Speed', value: '$currentWindSpeed'),
                  AdditionalInfoItem(icon: Icons.beach_access, label: 'Pressure', value: '$currentPressure'),
                  
                  
                ],
              ),
            ],
          ),
        );
        },
      ),
      
    );
  }
}







            // Card(
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(25),
            //     ),
            //   elevation: 13,
            //   color: Colors.greenAccent,
            //   shadowColor: Colors.green,
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(25),
            //     child: BackdropFilter(
            //       filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            //       child: const Padding(
            //         padding: EdgeInsets.all(16.0),
            //         child: Column(
            //           children: [
            //             Text(
            //               'Weather Forecast',
            //               style: TextStyle(
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 25,
            //               ),
            //             ),
            //             SizedBox(
            //               height: 10,
            //               ),
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 SizedBox(
            //                   width: 75,
            //                   child: Column(
            //                     children: [
            //                       Text('9:00'),
            //                       Icon(Icons.cloud, size:10),
            //                       Text('Temp'),
            //                     ],
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   width: 75,
            //                   child: Column(
            //                     children: [
            //                       Text('9:00'),
            //                       Icon(Icons.cloud, size:10),
            //                       Text('Temp'),
            //                     ],
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   width: 75,
            //                   child: Column(
            //                     children: [
            //                       Text('9:00'),
            //                       Icon(Icons.cloud, size:10),
            //                       Text('Temp'),
            //                     ],
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   width: 75,
            //                   child: Column(
            //                     children: [
            //                       Text('9:00'),
            //                       Icon(Icons.cloud, size:10),
            //                       Text('Temp'),
            //                     ],
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            
            /// additional Information
            // Card(
            //   shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(25),
            //     ),
            //   elevation: 13,
            //   color: Colors.blueGrey,
            //   shadowColor: Colors.blueGrey,
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(25),
            //     child: BackdropFilter(
            //       filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
            //       child: const Padding(
            //         padding: EdgeInsets.all(16.0),
            //         child: Column(
            //           children: [
            //             Text('Additional Information',
            //             style: TextStyle(
            //               fontWeight: FontWeight.bold,
            //               fontSize: 25,
            //               ),
            //             ),
            //             SizedBox(
            //               height: 10,
            //               ),
            //             Row(
            //               // crossAxisAlignment: CrossAxisAlignment.center,
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 SizedBox(
            //                   height: 75,
            //                   width: 100,
            //                   child: Column(
            //                     children: [
            //                       Icon(Icons.water_drop),
            //                       Text('Humidity',),
            //                       Text('91',),
            //                     ],
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   //height: 25,
            //                   width: 100,
            //                   child: Column(
            //                     children: [
            //                       Text('Wind Speed'),
            //                     ],
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   //height: 25,
            //                   width: 100,
            //                   child: Column(
            //                     children: [
            //                       Text('Pressure'),
            //                     ],
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),