import 'package:app_map/models/activity_model.dart';
import 'package:app_map/models/trip_model.dart';
import 'package:app_map/providers/trip_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TripActivityList extends StatelessWidget {
  final String tripId;
  final ActivityStatus filter ;

  TripActivityList({this.tripId, this.filter});


  @override
  Widget build(BuildContext context) {

    return Consumer<TripProvider>(builder: (context,tripProvider,child){  
       
      final TripModel trip = Provider.of<TripProvider>(context).getTripById(tripId);
      final List<ActivityModel> activities = trip.activities.where((activity) => activity.status == filter).toList();

      return ListView.builder(
      itemCount: activities.length,
      itemBuilder: (context, i)  {
        ActivityModel activity = activities[i];
          return Container(
            margin: EdgeInsets.all(10),
            child: filter == ActivityStatus.ongoing ? Dismissible(
            direction: DismissDirection.endToStart,
            background: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 30,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.greenAccent[700],
              ),
            ),
            key: ValueKey(activity.id),
            child: Card(
              child:ListTile(
                title: Text(activity.name),
              ),
            ),
            confirmDismiss: (_) {
              return Provider.of<TripProvider>(
                context,
                listen: false
              )
              .updateTrip(trip, activity.id).then((_) => true )
              .catchError((_) => false);
            },
            ) : Card(
              child:ListTile(
                title: Text(
                  activity.name,
                  style: TextStyle(
                    color: Colors.grey
                  ),
                ),
              ),
            ),
          );
      }
      );
      },
    ); 
  }
}