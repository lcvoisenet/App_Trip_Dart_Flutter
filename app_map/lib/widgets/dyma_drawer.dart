import 'package:flutter/material.dart';

import '../views/trips/trips_view.dart';
import '../views/home/home_view.dart';

class DymaDrawer extends StatelessWidget {

  const DymaDrawer();
  
  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child:ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text(
              "DymaTrip",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors:[
                  Theme.of(context).primaryColor ,
                  Theme.of(context).primaryColor.withOpacity(0.5)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight
              ), 
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Accueil"),
            onTap: () {
              Navigator.pushNamed(context, HomeView.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.airplanemode_active),
            title: Text("Mes Voyages"),
            onTap: () {
               Navigator.pushNamed(context, TripsView.routeName);
            },
          ),
        ],
      ),
    );
  }
}