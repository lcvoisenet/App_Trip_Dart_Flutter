
import 'package:app_map/models/activity_model.dart';
import 'package:app_map/views/trip/widgets/trip_activity_list.dart';
import 'package:flutter/material.dart';

class TripActivities extends StatelessWidget {
  final String tripId;

  TripActivities({this.tripId});

  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            Container(
              color: Theme.of(context).primaryColor,
               child: TabBar(
                 indicatorColor: Colors.blue[100],
                 unselectedLabelColor: Colors.black54,
                tabs: <Widget>[
                  Tab(child: Text("En cours"),),
                  Tab(child: Text("Terminé"),)
                ],
              ),
            ),
            Container(
              height: 600,
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  TripActivityList(
                    tripId: tripId,
                    filter: ActivityStatus.ongoing,
                  ),
                  TripActivityList(
                    tripId: tripId,
                    filter: ActivityStatus.done,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}