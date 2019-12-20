import 'package:flutter/material.dart';

import '../../../models/activity_model.dart';

import './activity_card.dart';

class ActivityList extends StatelessWidget {
  final List<ActivityModel> activities;
  final List<ActivityModel> selectedActivities;
  final Function toggleActivity;

  ActivityList({this.activities, this.selectedActivities, this.toggleActivity});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: activities.map(
        (activity) => ActivityCard(
          activity: activity,
          isSelected: selectedActivities.contains(activity),
          toggleActivity: () {
            toggleActivity(activity);
          }
        ),
      ).toList(),
    );
  }
}