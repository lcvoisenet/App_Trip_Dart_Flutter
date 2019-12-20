import 'package:flutter/foundation.dart';

enum ActivityStatus {ongoing , done}

class ActivityModel {

  String id;
  String name;
  String image;
  String city;
  double price;
  ActivityStatus status;
  LocationActivity location;


  ActivityModel({
    this.id, 
    this.location,
    @required this.name,
    @required this.image,
    @required this.city, 
    @required this.price,
    this.status = ActivityStatus.ongoing,
  });

  ActivityModel.fromJson(Map<String , dynamic> json) : 
  id = json['_id'],
  image = json['image'],
  name = json['name'],
  city = json['city'],
  price = json['price'].toDouble(),
  status = json['status'] == 0 ? ActivityStatus.ongoing : ActivityStatus.done;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> value = {
      'image' : image,
      'name' : name,
      'city' : city,
      'price' : price,
      'status' : status == ActivityStatus.ongoing ? 0 : 1 ,

    };
    if(id != null){
      value['_id'] = id;
    }
    return value;
  }
}

class LocationActivity {
  String address;
  double longitude;
  double latitude;
  
  LocationActivity({this.address,this.latitude,this.longitude});


}