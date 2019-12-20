



import 'package:app_map/views/activity_form/activity_form_view.dart';

import '../../providers/city_provider.dart';
import 'package:app_map/providers/trip_provider.dart';
import 'package:app_map/views/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/dyma_drawer.dart';

import '../../models/city_model.dart';
import '../../models/activity_model.dart';
import '../../models/trip_model.dart';

import './widgets/trip_activity_list.dart';
import './widgets/activity_list.dart';
import './widgets/trip_overview.dart';




class CityView extends StatefulWidget {
  static const String routeName = '/city';


  showContent({BuildContext context, List<Widget> children}) {
    final orientation = MediaQuery.of(context).orientation;

    if(orientation == Orientation.landscape){
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      );
    }else{
      return Column(
        children: children,
      );
    }
  }

  @override
  _CityState createState() => _CityState();
}

class _CityState extends State<CityView> with WidgetsBindingObserver {
  TripModel mytrip ;
  int index ;
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    index = 0 ;
    mytrip = TripModel(activities: [], city: null ,date: null,  );
  }

  double get amount {
    return mytrip.activities.fold(0.0, (prev,element) {
      return prev + element.price;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print(state);
  }

  @override
  void dispose(){
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  void setDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2020)
    )
    .then( (newDate) {
      if(newDate != null){
        setState(() {
          mytrip.date = newDate;
        });
      }
    });
  }

  void switchIndex(newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  void toggleActivity(ActivityModel activity){
    setState(() {
      mytrip.activities.contains(activity) ? mytrip.activities.remove(activity) : mytrip.activities.add(activity);
    });
    
  }

  void deleteTripActivity(ActivityModel activity){
    setState(() {
      mytrip.activities.remove(activity);
    });
  }

  void saveTrip(String cityName) async {
    final result = await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text("voulez vous savegarder ?"),
          contentPadding: const EdgeInsets.all(20),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  child: const Text("annuler",style: TextStyle(color: Colors.white),),
                  color: Theme.of(context).primaryColor,
                  onPressed: (){
                    Navigator.pop(context,"cancel");
                  },
                ),
                RaisedButton(
                  child: const Text("sauvegarder"),
                  onPressed: (){
                    Navigator.pop(context,"save");
                  },
                ),
              ],
            )
          ],
        );
      }
    );
    if(mytrip.date == null){
      showDialog(context: context,builder: (context) {
        return AlertDialog(
          title: const Text("Attention !"),
          content: const Text("Vous n'avez pas entré de date"),
          actions: <Widget>[
            FlatButton(
              child: const Text("ok"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
    }else if(result == 'save'){
      mytrip.city = cityName;
      Provider.of<TripProvider>(context).addTrip(mytrip);
      Navigator.pushNamed(context, HomeView.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {

    String cityName = ModalRoute.of(context).settings.arguments;
    CityModel city = Provider.of<CityProvider>(context).getCityByName(cityName);
    
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, ActivityFormView.routeName , arguments: cityName)
          ,)
        ],
        title: const Text("Organisation Voyage"),
      ),
      drawer: DymaDrawer(),
      body: Container(
          child: widget.showContent(
            context: context,
            children: <Widget>[
              TripOverview(
                cityName: city.name,
                trip: mytrip ,
                setDate: setDate,
                amount: amount,
                cityImage: city.image,
              ),
              Expanded(
                  child: index == 0
                  ? ActivityList(
                    activities: city.activities,
                    selectedActivities: mytrip.activities ,
                    toggleActivity: toggleActivity,
                  ) 
                  : TripActivityList(
                    activities: mytrip.activities,
                    deleteTripActivity: deleteTripActivity,
                  ),
              ),
            ],
          ), 
      ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.forward),
          onPressed: () {
            saveTrip(city.name);
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          items: [
            const BottomNavigationBarItem(icon: Icon(Icons.map) , title: Text("Découverte")),
            const BottomNavigationBarItem(icon: Icon(Icons.star), title: Text("Mes activitées"))
          ],
          onTap: switchIndex
        ),
      );
  }
}