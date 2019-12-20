import 'package:app_map/models/activity_model.dart';
import 'package:app_map/providers/city_provider.dart';
import 'package:app_map/views/activity_form/widgets/activity_form_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'activity_form_auto_complete.dart';


class ActivityForm extends StatefulWidget {
  
  final String cityName ;
  
  ActivityForm({this.cityName});

  @override
  _ActivityFormState createState() => _ActivityFormState();
}

class _ActivityFormState extends State<ActivityForm> {
  

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FocusNode _priceFocusNode;
  FocusNode _urlFocusNode;
  FocusNode _addressFocusNode;

  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  ActivityModel _newActivity;

  bool _isLoading = false;
  String _nameInputAsync;

  FormState get form {
    return _formKey.currentState;
  }

  @override
  void initState() {
    _newActivity = ActivityModel(
      city: widget.cityName,
      name: null,
      price: 0,
      image: null,
      location:LocationActivity(address:null,latitude: null,longitude: null),
      status: ActivityStatus.ongoing,
    );
    _priceFocusNode = FocusNode();
    _urlFocusNode = FocusNode();
    _addressFocusNode = FocusNode();
    _addressFocusNode.addListener(() async {
      if(_addressFocusNode.hasFocus){
        var location = await showInputAutoComplete(context);
        _newActivity.location = location;
        setState(() {
          _addressController.text = location.address;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _urlFocusNode.dispose();
    _addressFocusNode.dispose();
    _urlController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void updateUrlField(String url) {
    setState(() {
      _urlController.text = url ; 
    });
  }

  void _getCurrentLocation(){
    print('get location');
  }
  
  Future<void> submitForm() async {
    try{
      CityProvider cityProvider = Provider.of<CityProvider>(
          context ,
          listen: false
        );
        _formKey.currentState.save();
        setState(() => _isLoading = true);
        _nameInputAsync = await cityProvider.verifyIfActivityNameIsUnique(
          widget.cityName,
          _newActivity.name
        );
      if (form.validate()) {
        await cityProvider.addActivityToCity(_newActivity);
        Navigator.pop(context);
      }else{
        setState(() => _isLoading = false);
      }
    }catch(e){
      setState(() => _isLoading = false);
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              autofocus: true,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if(value.isEmpty) return "Completez le nom";
                else if (_nameInputAsync != null ) return _nameInputAsync;
                return null;
              },
              decoration: InputDecoration(
                labelText: "Nom"
              ),
              onSaved: (value) => _newActivity.name = value ,
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus( _priceFocusNode),
            ),
            SizedBox(height: 10,),
            TextFormField(
              textInputAction: TextInputAction.next,
              focusNode: _priceFocusNode,
              keyboardType: TextInputType.number,
               validator: (value) {
                if(value.isEmpty) return "Completez le prix";
                return null;
              },
              decoration: InputDecoration(
                labelText: "Price"
              ),
              onSaved: (value) => _newActivity.price = double.parse(value) ,
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_urlFocusNode),
            ),
            SizedBox(height: 10,),
            TextFormField(
              decoration: InputDecoration(labelText: "Adresse"),
              focusNode: _addressFocusNode,
              controller: _addressController,
              onSaved: (value) => _newActivity.location.address = value,
            ),
            SizedBox(height: 10,),
            FlatButton.icon(
              icon: Icon(Icons.gps_fixed),
              label: Text("Utiliser ma position actuelle"),
              onPressed: _getCurrentLocation
            ),
            SizedBox(height: 10,),
            TextFormField(
              focusNode: _urlFocusNode,
              controller: _urlController ,
              keyboardType: TextInputType.url,
               validator: (value) {
                if(value.isEmpty) return "Completez l'url";
                return null;
              },
              decoration: InputDecoration(
                labelText: "Url image"
              ),
              onSaved: (value) => _newActivity.image = value ,
            ),
            SizedBox(
              height: 10,
            ),
            ActivityFormImagePicker(updateUrl : updateUrlField),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  child: Text("Annuler"),
                  onPressed: () => Navigator.pop(context),
                ),
                RaisedButton(
                  child: Text("Sauvegarder"),
                  onPressed: _isLoading ? null : submitForm ,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}