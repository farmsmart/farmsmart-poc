import 'package:farmsmart/blocs/bloc_provider.dart';
import 'package:farmsmart/pages/factors/factors_bloc.dart';
import 'package:farmsmart/pages/recommendations/recommendations_bloc.dart';
import 'package:flutter/material.dart';

import 'package:farmsmart/pages/factors/update_factors.dart';
import 'package:farmsmart/pages/recommendations/recommended_crops.dart';

class RecommendationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RecommendationsBloc recommendationsBloc = BlocProvider.of(context);

    assert(recommendationsBloc != null, 'RecommendationsBloc is expected');

    return Scaffold(
      appBar: AppBar(
        title: Text('Recommended Crops'),
        leading: Icon(Icons.assistant),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.account_box, color: Colors.white),
          backgroundColor: Colors.green,
          onPressed: () async {
            var screen = FactorsBlocProvider(
                bloc: FactorsBloc(),
                widget: UpdateFactorsScreen());
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => screen)
            );
          }
      ),
      body: CropsPage(),
    );
  }

}