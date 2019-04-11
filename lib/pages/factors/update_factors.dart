import 'package:farmsmart/pages/factors/factors_bloc.dart';
import 'package:farmsmart/pages/factors/factors_db.dart';
import 'package:flutter/material.dart';

import 'package:farmsmart/blocs/bloc_provider.dart';


class UpdateFactorsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UpdateFactorsState();
}

class _UpdateFactorsState extends State<UpdateFactorsScreen> {
  String _location;

  String _landSize;

  String _soilType;

  String _irrigation;

  String _season;

  String _intention;

  void _update(FactorsBloc factors) {
    factors.update(
      location: _location,
      landSize: _landSize,
      soilType: _soilType,
      irrigation: _irrigation,
      season: _season,
      intention: _intention
    );
  }

  List<DropdownMenuItem<String>> _buildMenuItems(List<String> data) {
    List<DropdownMenuItem<String>> widgets = List();
    data?.forEach((key) {
      widgets.add(DropdownMenuItem<String>(
        child: Text(key, style: TextStyle(fontWeight: FontWeight.w300)),
        value: key,
      ));
    });
    return widgets;
  }


  Widget _buildDropDown(BuildContext context, Stream<List<String>> options, Function onChangedCallback, {defaultOption}) {
    return StreamBuilder<List<String>>(
      stream: options,
      builder: (context, snapshot) {
        return DropdownButton<String>(
          value: defaultOption,
          items: _buildMenuItems(snapshot.data),
          onChanged: onChangedCallback,
        );
      },
    );
  }

    @override
  Widget build(BuildContext context) {
    FactorsBloc factorsBloc = BlocProvider.of(context);

    _location = factorsBloc.location;
    _landSize = factorsBloc.landSize;
    _intention = factorsBloc.intention;
    _season = factorsBloc.season;
    _irrigation = factorsBloc.irrigation;
    _soilType = factorsBloc.soilType;

    return Scaffold(
      //key : _scaffoldState,
      appBar: AppBar(
        title: Text('Recommendation Factors')
      ),
      body: ListView(
        children: <Widget> [
          ListTile(
            leading: Icon(Icons.my_location),
            title: Text('Location'),
            trailing: _buildDropDown(context, factorsBloc.getLocationValues(), (location) {
              setState(() {
                this._location = location;
                _update(factorsBloc);
              });
            }, defaultOption: _location ?? factorsBloc.location ),
          ),
          ListTile(
            leading: Icon(Icons.landscape),
            title: Text('Land Size'),
            trailing: _buildDropDown(context, factorsBloc.getLandSizeValues(), (landSize) {
              setState(() {
                this._landSize = landSize;
                _update(factorsBloc);
              });
            }, defaultOption: _landSize ?? factorsBloc.landSize),
          ),
          ListTile(
            leading: Icon(Icons.crop_original),
            title: Text('Soil Type'),
            trailing: _buildDropDown(context, factorsBloc.getSoilTypeValues(), (soilType) {
              setState(() {
                this._soilType = soilType;
                _update(factorsBloc);
              });
            }, defaultOption: _soilType ?? factorsBloc.soilType)
          ),
          ListTile(
            leading: Icon(Icons.filter_drama),
            title: Text('Irrigation'),
            trailing: _buildDropDown(context, factorsBloc.getIrrigationValues(), (irrigation) {
              setState(() {
                this._irrigation = irrigation;
                _update(factorsBloc);
              });
            }, defaultOption: _irrigation ?? factorsBloc.irrigation)
          ),
          ListTile(
            leading: Icon(Icons.ac_unit),
            title: Text('Season'),
            trailing: _buildDropDown(context, factorsBloc.getSeasonValues(), (season) {
              setState(() {
                this._season = season;
                _update(factorsBloc);
              });
            }, defaultOption: _season ?? factorsBloc.season)
          ),
          ListTile(
            leading: Icon(Icons.monetization_on),
            title: Text('Intention'),
            trailing: _buildDropDown(context, factorsBloc.getIntentionValues(), (intention) {
              setState(() {
                this._intention = intention;
                _update(factorsBloc);
              });
            }, defaultOption: _intention ?? factorsBloc.intention)
          )
        ]
      )
    );
  }

}