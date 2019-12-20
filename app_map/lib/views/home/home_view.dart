
import 'package:app_map/providers/city_provider.dart';
import 'package:app_map/widgets/dyma_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../widgets/dyma_drawer.dart';

import './widgets/city_card.dart';

import '../../models/city_model.dart';


class HomeView extends StatefulWidget {
  static const String routeName = '/';

  @override
  _HomeState createState(){
    return _HomeState();
  }
}

class _HomeState extends State<HomeView>{
  TextEditingController searchController = TextEditingController();
  
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CityProvider cityProvider = Provider.of<CityProvider>(context);
    List<CityModel> filteredCities = cityProvider.getFilteredCities(searchController.text);
    return Scaffold(
        appBar: AppBar(
          title: const Text("DymaTrip"),
        ),
        drawer: const DymaDrawer(),
        body: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children:<Widget>[
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: "Rechercher un ville",
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      setState(() => searchController.clear());
                    },
                  ),
                ] 
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10) ,
                child: RefreshIndicator(
                  onRefresh: Provider.of<CityProvider>(context).fetchData ,
                  child: cityProvider.isLoading
                  ? DymaLoader() 
                  : filteredCities.length > 0 
                  ? ListView.builder(
                    itemCount: filteredCities.length,
                    itemBuilder: (_,index) => CityCard( 
                     city: filteredCities[index],
                    ),
                  ) : Text("Aucun résultat ! "),
                ),
              ),
            ),
          ],
            
        )
      );
    }
}
  
