// This sample shows creation of a [Card] widget that can be tapped. When
// tapped this [Card]'s [InkWell] displays an "ink splash" that fills the
// entire card.

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Code Sample for material.Card',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyStatelessWidget(),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  Widget buildListItem(BuildContext context, DocumentSnapshot document) {
    return ListTile(
        title: Text(document.documentID),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('FarmSmart Recommends')
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('fs_crop_scores').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Text('Loading crops...');
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemExtent: 60.0,
            itemBuilder: (context, index) =>
                buildListItem(context, snapshot.data.documents[index])
          );
        }
      )
    );
  }
}