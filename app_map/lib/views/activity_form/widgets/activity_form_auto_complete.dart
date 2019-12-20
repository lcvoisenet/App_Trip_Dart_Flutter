
import 'package:app_map/apis/google_api.dart';
import 'package:app_map/models/activity_model.dart';
import 'package:app_map/models/place_model.dart';
import 'package:app_map/views/activity_form/activity_form_view.dart';

import 'package:flutter/material.dart';
import 'dart:async';

Future<LocationActivity> showInputAutoComplete(BuildContext context) {
//   return Navigator.push(context, MaterialPageRoute(
//   builder: (BuildContext context) {
//     return InputAddress();
//   }
// ));
  return showDialog(
    context: context,
    builder: (_) =>  InputAddress(),
  );
}

class InputAddress extends StatefulWidget {
  @override
  _InputAddressState createState() => _InputAddressState();
}

class _InputAddressState extends State<InputAddress> {
  List<PlaceModel> _places = [];
  Timer _debounce ;



  Future<void> _searchAddress(String value) async {
    try {
      if(_debounce?.isActive == true) _debounce.cancel();
    _debounce = Timer(Duration(seconds: 1),() async {
      print(value);
      if(value.isNotEmpty){ 
      _places = await getAutoCompleteSuggestions(value);
      setState(() {});
      }
    });
    } catch (e) {
      rethrow;
    }
  } 

  Future<void> getPlaceDetails(String placeId) async {
    try {
      LocationActivity location = await getPlaceDetailsApi(placeId);
      if(location != null ){
        print(location);
        return Navigator.pop(context,location);
      }else{
        return Navigator.popAndPushNamed(context,ActivityFormView.routeName);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: "Rechercher",
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: _searchAddress,
              ),
              Positioned(
                right: 10,
                top: 5,
                child: IconButton(
                  icon: Icon(Icons.clear), 
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _places.length,
              itemBuilder: (_,i){
                var place = _places[i];
                return ListTile(
                  leading: Icon(
                    Icons.place
                  ),
                  title: Text(place.description),
                  onTap: () => getPlaceDetails(place.placeId),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}