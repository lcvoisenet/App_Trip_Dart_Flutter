import 'package:app_map/models/city_model.dart';
import 'package:flutter/material.dart';

class TripCityBar extends StatelessWidget {
  final CityModel city;

  TripCityBar({this.city});

  @override
  Widget build(BuildContext context) {
    
    return Container(
      height: 200,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: <Widget>[
          Image.network(city.image , fit: BoxFit.cover,),
          Container(
            color: Colors.black38,
            padding: EdgeInsets.symmetric(
              vertical: 30,
              horizontal: 10
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      city.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}