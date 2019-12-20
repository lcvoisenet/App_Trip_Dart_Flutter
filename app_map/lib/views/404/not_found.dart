import 'package:app_map/widgets/dyma_drawer.dart';
import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {

  const NotFound();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DymaDrawer(),
      body: Container(
        alignment: Alignment.center,
        child: const Text('ooops not found'),
      ),
    );
  }
}