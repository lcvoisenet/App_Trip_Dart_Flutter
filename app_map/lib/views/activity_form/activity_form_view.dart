import 'package:app_map/views/activity_form/widgets/activity_form.dart';

import 'package:app_map/widgets/dyma_drawer.dart';
import 'package:flutter/material.dart';

class ActivityFormView extends StatelessWidget {
   
  static const String routeName = "/activity-form-view"; 

  @override
  Widget build(BuildContext context) {
    String cityName = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter une activité"),
      ),
      drawer: DymaDrawer(),
      body:  SingleChildScrollView(child: ActivityForm(cityName:cityName)),
    );
  }
}