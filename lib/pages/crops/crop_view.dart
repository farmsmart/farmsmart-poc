import 'package:flutter/material.dart';

class CropViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crop'),
      ),
      body: ListView(
        children : <Widget>[
          ListTile(
            title: Text('Details of the crop'),
            subtitle: ButtonBar(
              children: <Widget>[
                RaisedButton(
                  child: Text('Add to plot')
                )
              ]
            ),
          )
        ]
      )
    );
  }

}