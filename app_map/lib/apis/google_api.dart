import 'package:app_map/models/activity_model.dart';
import 'package:app_map/models/place_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const GOOGLE_API_KEY = "AIzaSyDJthuuoHLMt8kOkoK_YAkHtxi3quApQjY";

Uri _queryAutoCompleteBuilder(String query){
  return Uri.parse("https://maps.googleapis.com/maps/api/place/queryautocomplete/json?key=$GOOGLE_API_KEY&input=$query");
}

Future<List<PlaceModel>> getAutoCompleteSuggestions(String query) async {
  try {
     var response = await http.get(_queryAutoCompleteBuilder(query));
     if(response.statusCode == 200){
       var body = json.decode(response.body);
       return (body['predictions'] as List).map((suggestion) => PlaceModel(
         description:suggestion['description'] ,
         placeId:suggestion['place_id'] 
      )).toList();
     }else{
       return [];
     }
  } catch (e) {
    rethrow;
  }
  
} 

Uri _queryPlaceDetailsBuilder(String placeId) {
  return Uri.parse("https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeId&fields=formatted_address,geometry&key=$GOOGLE_API_KEY");
}

Future<LocationActivity> getPlaceDetailsApi(String placeId) async {
  try {
    var response = await http.get(_queryPlaceDetailsBuilder(placeId));
    if(response.statusCode == 200){
      var body = json.decode(response.body)["result"];
      return LocationActivity(
        address: body["formatted_address"],
        longitude: body["geometry"]["location"]["lng"],
        latitude: body["geometry"]["location"]["lat"]);
    }else{
      return null;
    }
  } catch (e) {
    rethrow;
  }    
}