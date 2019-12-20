
import 'package:app_map/providers/trip_provider.dart';
import 'package:app_map/widgets/dyma_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../views/trips/widgets/trip_list.dart';

import '../../widgets/dyma_drawer.dart';



class TripsView extends StatelessWidget {
  static const String routeName = "/trips"; 

  @override
  Widget build(BuildContext context) {
    TripProvider tripProvider = Provider.of<TripProvider>(context);

    return DefaultTabController(
        length: 2,
        child: Scaffold(
        appBar: AppBar(
          title: const Text("Mes Voyages"),
          bottom: TabBar(
            indicatorColor: Colors.blue[100] ,
            unselectedLabelColor: Colors.black54,
            tabs: <Widget>[
              const Tab(text: "A venir", icon: Icon(Icons.timer),),
              const Tab(text: "Passée", icon: Icon(Icons.restore),)
            ],
          )
        ),
        drawer: const DymaDrawer(),
        body: tripProvider.isLoading != true  
        ? tripProvider.trips.length > 0 ? TabBarView(
          children: <Widget>[
          TripList(trips: tripProvider.trips.where((trip) => DateTime.now().isBefore(trip.date)).toList()),
          TripList(trips: tripProvider.trips.where((trip) => DateTime.now().isAfter(trip.date)).toList()),
        ],
        ) : Container(alignment: Alignment.center, child: Text("Aucun Voyages pour le moment "),) 
          : DymaLoader(),
      ),
    );
  }
}