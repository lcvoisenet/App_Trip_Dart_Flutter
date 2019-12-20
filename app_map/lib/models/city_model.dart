import 'package:flutter/foundation.dart';

import './activity_model.dart';

class CityModel {
  String id ;
  String image;
  String name;
  List<ActivityModel> activities;

  CityModel({
    @required this.id,
    @required this.image, 
    @required this.name, 
    @required this.activities,
  });

  CityModel.fromJson(Map<String, dynamic> json) : 
  id = json['_id'],
  image = json['image'],
  name = json['name'],
  activities = (json['activities'] as List)
  .map((activityJson) => ActivityModel.fromJson(activityJson)
  )
  .toList();
}