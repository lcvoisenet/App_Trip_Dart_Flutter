import 'dart:collection';
import 'dart:io';

import 'package:app_map/models/activity_model.dart';
import 'package:app_map/models/trip_model.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class TripProvider with ChangeNotifier{
  final String host = "http://10.0.2.2:80";
  List<TripModel> _trips = [];
  bool isLoading = false;

  UnmodifiableListView<TripModel> get trips => UnmodifiableListView(_trips);

  Future<void> fetchData() async {
    try{
      isLoading = true;
      http.Response response = await http.get('$host/api/trips');
      print(response.statusCode);
      if(response.statusCode == 200){
        _trips = (json.decode(response.body)as List).map((tripJson) => TripModel.fromJson(tripJson) ).toList();
        isLoading = false;
        notifyListeners();
      }
    }catch(e){
       isLoading = false;
      rethrow;
    }
  }


  Future<void> addTrip(TripModel trip) async {
    try{
      http.Response response = await http.post(
        '$host/api/trip',
        body: json.encode(trip.toJson()), 
        headers : {'Content-type' : 'application/json'},
      );
      if(response.statusCode == 200){
        _trips.add(TripModel.fromJson(json.decode(response.body),),);
      }
      notifyListeners();
    }catch(e){
      rethrow;
    }
   
  } 

  TripModel getTripById(String tripId) => trips.firstWhere((trip) => trip.id == tripId);

  Future<void> updateTrip(TripModel trip,String activityId) async {
    try{
      ActivityModel activity = trip.activities
      .firstWhere(
        (activity) => activity.id == activityId
      );
      activity.status = ActivityStatus.done;
      http.Response response = await http.put(
        "$host/api/trip",
        body: json.encode(trip.toJson(),
        ),
        headers: {'Content-type' : 'application/json',}
      );
      if(response.statusCode != 200){
        activity.status = ActivityStatus.ongoing;
        throw HttpException('Error');
      }
      notifyListeners();
    }catch(e){
      rethrow;
    }
    
  }

}