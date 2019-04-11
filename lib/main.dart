// This sample shows creation of a [Card] widget that can be tapped. When
// tapped this [Card]'s [InkWell] displays an "ink splash" that fills the
// entire card.

import 'package:farmsmart/pages/recommendations/recommendations_bloc.dart';
import 'package:flutter/material.dart';
import 'package:farmsmart/pages/recommendations/recommendations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Code Sample for material.Card',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
//      routes: {
//        '/test' : (context) {
//          Navigator.pushNamed(context, '/recommendations');
//          return Text('Hello World');
//        },
//        '/' : (context) {
//          return RecommendationsBlocProvider(
//              bloc: RecommendationsBloc(),
//              widget: RecommendationsScreen()
//          );
//        }
//      },
      home: RecommendationsBlocProvider(
          bloc: RecommendationsBloc(),
          widget: RecommendationsScreen()
      )
    );
  }
}
