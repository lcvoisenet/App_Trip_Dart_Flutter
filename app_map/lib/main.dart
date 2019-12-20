import 'package:app_map/providers/city_provider.dart';
import 'package:app_map/providers/trip_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './views/404/not_found.dart';
import './views/trips/trips_view.dart';
import './views/city/city_view.dart';
import './views/home/home_view.dart';
import './views/trip/trip_view.dart';
import './views/activity_form/activity_form_view.dart';





main(){
  runApp(DymaTrip());
}

class DymaTrip extends StatefulWidget{
  
  @override
  _DymaTripState createState() => _DymaTripState();
}

class _DymaTripState extends State<DymaTrip> {

  final CityProvider cityProvider = CityProvider();
  final TripProvider tripProvider = TripProvider();

  @override
  void initState() {
    cityProvider.fetchData();
    tripProvider.fetchData();
    super.initState();
  }
  

  // void addTrip( TripModel trip) {
  //   setState(() {
  //     trips.add(trip);
  //   });
  //   print(trip);
  // }

  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: cityProvider,),
        ChangeNotifierProvider.value(value: tripProvider,),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          //initialRoute: '/city',
          routes: {
            HomeView.routeName:(_) => HomeView(),
            CityView.routeName:(_) => CityView(),
            TripsView.routeName:(_) => TripsView(),
            TripView.routeName:(_) => TripView(),
            ActivityFormView.routeName:(_) => ActivityFormView(),
          },
        
        onUnknownRoute: (_){
          return MaterialPageRoute(builder: (_) => NotFound(),);
        },
      ),
    );  
  }
}