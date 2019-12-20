import 'package:app_map/widgets/dyma_loader.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TripWeather extends StatelessWidget {
  final String cityName;
  final String hostBase = "https://api.openweathermap.org/data/2.5/forecast?q=";
  final String apiKey = "&APPID=8cdcca32148c1035c366fb7e40f0d02b";

  TripWeather({this.cityName});

  String get query => '$hostBase$cityName$apiKey';

  Future<String> get getWeather {
    return http.get(query).then((http.Response response) {
      Map<String , dynamic> body = json.decode(response.body);
      return body['list'][0]['weather'][0]['icon'] as String;
    }).catchError((error) => "error");
  }

  String getIconUrl(String iconName) {
    return "https://openweathermap.org/img/wn/$iconName@2x.png";
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getWeather,
      builder: (_,snapshot) {
        if(snapshot.hasError){
          return Text('error');
        }else if(snapshot.hasData){
          return Card(
            margin: EdgeInsets.all(10),
            color: Colors.blue[200],
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 55,
                vertical: 5
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Météo',
                    style: TextStyle(
                      fontSize: 30
                    ),
                  ),
                  Image.network(
                    getIconUrl(snapshot.data),
                    height: 50,
                    width: 50,
                  ),
                ],
              ),
            ),
          );
        }else{
          return DymaLoader();
        }
      },

    );
  }
}