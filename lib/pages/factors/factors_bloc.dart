import 'dart:async';

import 'package:farmsmart/blocs/bloc_provider.dart';
import 'package:farmsmart/pages/factors/factors_db.dart';
import 'package:farmsmart/pages/recommendations/recommendations_bloc.dart';
import 'package:farmsmart/resources/user_prefs_repostiory.dart';


class FactorsBlocProvider extends  BlocProvider<FactorsBloc> {
  FactorsBlocProvider({bloc, widget}) : super(bloc: bloc, child: widget);
}

class FactorsBloc implements BlocBase {
  UserPreferencesRepository _userPref = UserPreferencesRepository.get();
  FactorsDB _factorsDB = FactorsDB.get();

  String location;
  String intention;
  String season;
  String soilType;
  String irrigation;
  String landSize;

  StreamSubscription<RecommendationPreference> _prefSub;

  FactorsBloc() {
    _prefSub = _userPref.recommendationPreferenceSource.listen(_receivePreference);
  }

  void _receivePreference(RecommendationPreference pref) {
    print('Received recommendation preference');
    location = pref.location;
    intention = pref.intention;
    season = pref.season;
    irrigation = pref.irrigation;
    soilType = pref.soilType;
    landSize = pref.landSize;
  }

  // Dispose
  @override
  void dispose() {
    _prefSub.cancel();
  }

  Stream<List<String>> getLocationValues() {
    return Stream.fromFuture(_factorsDB.getLocations());
  }

  Stream<List<String>> getLandSizeValues() {
    return Stream.fromFuture(_factorsDB.getLandSize());
  }

  Stream<List<String>> getSoilTypeValues() {
    return Stream.fromFuture(_factorsDB.getSoilType());
  }

  Stream<List<String>> getIrrigationValues() {
    return Stream.fromFuture(_factorsDB.getIrrigation());
  }

  Stream<List<String>> getSeasonValues() {
    return Stream.fromFuture(_factorsDB.getSeason());
  }

  Stream<List<String>> getIntentionValues() {
    return Stream.fromFuture(_factorsDB.getIntention());
  }

  void update({location, landSize, soilType, irrigation, season, intention}) {
    _userPref.updateRecommendations(
      location: location,
      landSize: landSize,
      soilType: soilType,
      irrigation: irrigation,
      season: season,
      intention: intention
    );
  }

}