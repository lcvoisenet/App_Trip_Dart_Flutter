import 'package:app_map/models/activity_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class TripModel{
  String city;
  List<ActivityModel> activities;
  DateTime date;
  String id;

  TripModel({ 
    @required this.city,
    @required this.activities,
    @required this.date,
  });

  TripModel.fromJson(Map<String, dynamic> json) : 
  id = json["_id"],
  city = json["city"],
  date = DateTime.parse(json["date"]),
  activities = (json["activities"]as List)
  .map((activityJson) => ActivityModel.fromJson(activityJson) 
  )
  .toList();

  Map<String , dynamic> toJson() {
    return {
      '_id' : id,
      'city' : city,
      'date' : date.toIso8601String(),
      'activities' : activities.map((activity) => activity.toJson()).toList(),
    };
  }
}