import 'package:app_map/models/trip_model.dart';
import 'package:app_map/views/city/widgets/trip_overview_city.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class TripOverview extends StatelessWidget {
  final Function setDate;
  final TripModel trip;
  final String cityName;
  final double amount;
  final String cityImage;


  TripOverview({this.setDate,this.trip,this.cityName,this.amount,this.cityImage});
  


  @override
  Widget build(BuildContext context) {

    final orientation = MediaQuery.of(context).orientation;
    final size = MediaQuery.of(context).size;

    return Container(
      width: orientation == Orientation.landscape ? size.width * 0.5 : size.width,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
             Container(
              child: TripOverviewCity(cityName: cityName, cityImage: cityImage,), 
            ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: <Widget>[
               Expanded(
                 child: Text(
                   trip.date != null ?
                   DateFormat("d/M/y").format(trip.date) : "choisissez une date",
                   style: const TextStyle(fontSize: 20),
                )
              ),
               RaisedButton(
                child: const Text("Selectionnez une date"),
                onPressed: setDate,
               )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: <Widget>[
                const Expanded(
                  child: Text(
                  "Montant / personne",
                  style: TextStyle(fontSize: 20),
                 ),
                ),
                Text(
                  "$amount €",
                  style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}