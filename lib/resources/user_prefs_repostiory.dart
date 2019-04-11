import 'package:rxdart/rxdart.dart';

class UserPreferencesRepository {
  static final UserPreferencesRepository _instance = UserPreferencesRepository._internal();

  UserPreferencesRepository._internal();

  RecommendationPreference _recommendationPreference = RecommendationPreference();

  static UserPreferencesRepository get() {
    return _instance;
  }

  // TODO: Is it safe to have streams on global objects?
  // ignore: close_sinks
  BehaviorSubject<RecommendationPreference> _subject = BehaviorSubject<RecommendationPreference>(
      seedValue: RecommendationPreference());
  Stream<RecommendationPreference> get recommendationPreferenceSource => _subject.stream;

  Future<RecommendationPreference> getRecommendationPreference() async {
    return _recommendationPreference;
  }

  void updateRecommendationPreference(RecommendationPreference pref) {
    _recommendationPreference = pref;
    _subject.sink.add(_recommendationPreference);
  }

  void updateRecommendations({location, landSize, soilType, irrigation, season, intention}) {
    updateRecommendationPreference(
      RecommendationPreference(
        location: location,
        landSize: landSize,
        soilType: soilType,
        irrigation: irrigation,
        season: season,
        intention: intention
      )
    );
  }

}

class RecommendationPreference {
  String location;
  String landSize;
  String soilType;
  String irrigation;
  String season;
  String intention;

  RecommendationPreference({
    this.location : 'Garissa',
    this.landSize : 'Less than 10m2',
    this.soilType : 'Sandy',
    this.irrigation : 'Yes',
    this.season : 'Short Rains',
    this.intention : 'Both'
  });

  Map<String, String> asMap() {
    return {
      'Location' : location,
      'Land Size' : landSize,
      'Soil Type' : soilType,
      'Irrigation' : irrigation,
      'Season' : season,
      'Intention' : intention
    };
  }
}