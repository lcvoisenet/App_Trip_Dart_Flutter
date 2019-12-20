import 'dart:collection';
import 'dart:io';
import 'package:app_map/models/activity_model.dart';
import 'package:app_map/models/city_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';


class CityProvider with ChangeNotifier{

  List<CityModel> _cities = [];

  UnmodifiableListView<CityModel> get cities => UnmodifiableListView(_cities);
  final String host = "http://10.0.2.2:80";
  bool isLoading = false;

  CityModel getCityByName(String cityName) => cities.firstWhere((city) => city.name == cityName);

  UnmodifiableListView<CityModel> getFilteredCities(String filter) => 
    UnmodifiableListView(_cities.where(
      (city) => city.name.toLowerCase().startsWith(
        filter.toLowerCase(),
      ),
    )
      .toList(),
    );

  Future<void> fetchData() async {
    try{
      isLoading = true;
      http.Response response = await http.get("$host/api/cities");
      print(response.statusCode);
      if(response.statusCode == 200){
        _cities = (json.decode(response.body) as List)
        .map((cityJson) => CityModel.fromJson(cityJson)
        )
        .toList();
        isLoading = false;
        notifyListeners();
      }
    }catch(e){
      isLoading = false;
      rethrow;
    }
    
  }

  Future<void> addActivityToCity(ActivityModel newActivity) async {
    
    try{
      String cityId = getCityByName(newActivity.city).id;
      http.Response response = await http.post(
      "$host/api/city/$cityId/activity" ,
      headers: {
      'Content-type' : "application/json"
      },
      body: json.encode(
        newActivity.toJson(),
      )
    );
    if(response.statusCode == 200){
      int index = _cities.indexWhere((city) => city.id == cityId);
      _cities[index] = CityModel.fromJson(
        json.decode(response.body),
      );
      notifyListeners();
    }
    }catch(e){
      rethrow;
    }
  }
  Future<dynamic>verifyIfActivityNameIsUnique(String cityName , String activityName) async {
    try{
      CityModel city = getCityByName(cityName);
      http.Response response = await http.get("$host/api/city/${city.id}/activities/verify/$activityName");
      if(response.body != null ){
        return json.decode(response.body);
      }
    }catch(e){
      rethrow;
    }
  }

  Future<String> uploadImage(File pickedImage) async {
    try {
    var request = http.MultipartRequest("POST" , Uri.parse('$host/api/activity/image'),);
    
    request.files.add(
      http.MultipartFile.fromBytes(
        "activity",
        pickedImage.readAsBytesSync(),
        filename: basename(pickedImage.path),
        contentType: MediaType("multipart" , "form-data"),
      )
    );
    var response = await request.send();

    if(response.statusCode == 200){
      var responseData = await response.stream.bytesToString();
      print(responseData);
      return json.decode(responseData);
    }else{
      throw "error provider";
    }
    } catch (e) {
      rethrow;
    }
    
  }

  }
