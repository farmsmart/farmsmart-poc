import 'dart:core';

import 'package:farmsmart/blocs/bloc_provider.dart';
import 'package:farmsmart/pages/recommendations/recommendations_bloc.dart';
import 'package:flutter/material.dart';

import 'package:farmsmart/pages/crops/crop_view.dart';

class CropsPage extends StatelessWidget {

  String _formatRating(double score) {
    if (score == null || score == 0) {
      return '';
    } else {
      return score.toStringAsPrecision(2) + ' %';
    }
  }

  Widget _buildCropWidget(RatedRecommendation crop) {
    return SizedBox(
      height: 80,
      child: Card(
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.add_circle_outline, color: Colors.green,),
              subtitle: Text('Add to my plot',
                style: TextStyle(fontSize: 14)),
              isThreeLine: false,
              title: Text(crop.cropName,
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 20),),
              trailing: Text(_formatRating(crop.score),
                style: TextStyle(fontStyle: FontStyle.italic, color: Colors.green[700], fontSize: 18)),
            ),
            //Divider(),
            // TODO: Add additional information here.
          ]
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    RecommendationsBloc bloc = BlocProvider.of(context);

    return StreamBuilder(
      stream: bloc.cropRecommendations,
      builder: (context, recommendations) {
        List<Widget> cropWidgets = List<Widget>();

        for(RatedRecommendation crop in recommendations?.data ?? []) {
          cropWidgets.add(_buildCropWidget(crop));
        }

        return Column(
          children: cropWidgets,
        );
      },
    );
  }

}