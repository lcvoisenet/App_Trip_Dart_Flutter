

import 'package:app_map/models/activity_model.dart';
import 'package:flutter/material.dart';

class TripActivityCard extends StatefulWidget {
  final ActivityModel activity;
  final Function deleteTripActivity;

  // Color getColor(){
  //   const colors = [Colors.blue,Colors.red];
  //   return colors[Random().nextInt(2)];
  // }

  TripActivityCard({Key key,this.activity,this.deleteTripActivity}): super(key:key);

  @override
  _TripActivityCardState createState() => _TripActivityCardState();
}

class _TripActivityCardState extends State<TripActivityCard> {
  Color color;

  @override
  void initState() {
    // color = widget.getColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
            widget.activity.image
          ),
        ),
        title: Text(widget.activity.name, style: TextStyle(color: color)),
        subtitle: Text(widget.activity.city),
        trailing: IconButton(
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: () {
            widget.deleteTripActivity(widget.activity.id);
            Scaffold.of(context).showSnackBar(SnackBar(
              content: const Text("activité supprimée"),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
              ),
            );
          },
        ),
      ),
    );
  }
}