import 'package:app_map/models/activity_model.dart';
import 'package:app_map/views/city/widgets/trip_activity_card.dart';
import 'package:flutter/material.dart';

class TripActivityList extends StatelessWidget {
  final List<ActivityModel> activities;
  final Function deleteTripActivity;

  TripActivityList({this.activities,this.deleteTripActivity});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (context,index){
          var activity = activities[index];
          return TripActivityCard(
            key: ValueKey(activity.id),
            activity: activity,
            deleteTripActivity: deleteTripActivity,
          );
        },
        itemCount: activities.length,
      ),
    );
  }
}