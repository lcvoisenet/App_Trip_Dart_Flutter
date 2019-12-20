
import '../../../models/activity_model.dart';

import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  final ActivityModel activity;
  final bool isSelected;
  final Function toggleActivity;


  ActivityCard({this.activity, this.isSelected , this.toggleActivity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      margin: const EdgeInsets.all(1),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Ink.image(
            image: NetworkImage(activity.image),
            fit: BoxFit.cover,
            child: InkWell(
              onTap: toggleActivity,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      if(isSelected)
                        const Icon(Icons.check, size: 40,color: Colors.white,)
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: FittedBox(
                        child: Text(
                          activity.name,
                          style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ]
      ,),
    );
  }
}