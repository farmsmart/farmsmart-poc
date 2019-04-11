import 'dart:async';

import 'package:farmsmart/blocs/bloc_provider.dart';
import 'package:farmsmart/models/crop_score_model.dart';
import 'package:farmsmart/resources/cms_crop_repository.dart';
import 'package:farmsmart/resources/crop_score_link_repository.dart';
import 'package:farmsmart/resources/crop_score_repository.dart';
import 'package:farmsmart/resources/user_prefs_repostiory.dart';
import 'package:rxdart/rxdart.dart';

class RecommendationsBloc extends BlocBase {
  UserPreferencesRepository _userRepo = UserPreferencesRepository.get();
  StreamSubscription<RecommendationPreference> _prefSub;

  CropCmsRepository _cropCmsRepo;
  StreamSubscription<List<CropCms>> _cropCmsSub;

  CropScoreRepository _cropScoreRepo;
  StreamSubscription<List<CropScore>> _cropScoreSub;

  CropLinkRepository _cropLinkRepo;
  StreamSubscription<List<CropLink>> _cropLinkSub;

  static const String DEFAULT_LOCALE = 'en-US';

  RecommendationsBloc({locale : RecommendationsBloc.DEFAULT_LOCALE}) {
    // subscribe to recommend
    _cropCmsRepo = CropCmsRepository(locale: locale);
    _subscribeToCmsCropUpdates();

    _cropScoreRepo = CropScoreRepository();
    _subscribeToScoreUpdates();

    _cropLinkRepo = CropLinkRepository(locale: locale);
    _subscribeToLinkUpdates();

    _prefSub = _userRepo.recommendationPreferenceSource
        .listen(_handleRecommendationPrefChange);
  }

  Map<String, CropCms> _cmsCropLookup = Map<String, CropCms>();
  Map<String, CropScore> _cmsScoreLookup = Map<String, CropScore>();
  Map<String, CropLink> _cmsLinkLookup = Map<String, CropLink>();

  BehaviorSubject<List<RatedRecommendation>> _ratedRecommendations =
      BehaviorSubject<List<RatedRecommendation>>(seedValue: []);

  Stream<List<RatedRecommendation>> get cropRecommendations =>
      _ratedRecommendations.stream;

  @override
  void dispose() async {
    // clean subscriptions to various streams
    await _cropCmsSub?.cancel();
    await _prefSub?.cancel();
    await _cropScoreSub.cancel();
    await _cropLinkSub.cancel();

    _ratedRecommendations?.close();

    _cropCmsRepo?.close();
    _cropCmsRepo = null;

  }

  void _handleRecommendationPrefChange(RecommendationPreference pref) {
    print('Recommendation Factors updated. Recalculate recommendations');
    _recalculate(pref);
  }

  void _recalculate(RecommendationPreference pref) {

    if (pref == null) {
      return;
    }

    print('>> Recalculating recommendations');
    List<RatedRecommendation> recommendations = List<RatedRecommendation>();

    // 1. get all scores and recalculate based on updated factors
    Map<String, double> scoreLookup = Map<String, double>();
    Map<String, String> factors = pref.asMap();
    for(CropScore each in _cmsScoreLookup.values) {
      scoreLookup.putIfAbsent(each.crop, () => each.calculate(factors));
    }

    // 2. update recommendations with the new crop scores. use cms ID to support multilanguage
    for(CropCms data in _cmsCropLookup.values) {
      String crop = _cmsLinkLookup[data.externalId]?.crop;
      double score = scoreLookup[crop] ?? 0.0;

      recommendations.add(RatedRecommendation(
          cropName: '${data.name} - ${data.type}',
          score: score));
    }

    // 3. sort the recommendations
    recommendations.sort((thisRate, thatRate) {
      var thisCrop = thisRate.cropName.toLowerCase();
      var thatCrop = thatRate.cropName.toLowerCase();

      int scoreComparison = (thisRate?.score ?? 0.0).compareTo(thatRate?.score ?? 0.0) * -1;

      return ( scoreComparison == 0) ? (thisCrop.compareTo(thatCrop)) : scoreComparison;

    });

    // 4. publish the recommendation
    _publishRecommendationUpdates(recommendations);

  }

  void _subscribeToCmsCropUpdates() async {
    _cropCmsSub = _cropCmsRepo.createSubscription().listen((data) {
      print('CMS crops updated. recalculate recommendations.');
      _fetchCmsCrops(data);
    });
  }

  void _subscribeToLinkUpdates() async {
    _cropLinkSub = _cropLinkRepo.createSubscription().listen((data) {
      print('CMS Links to Scores updated. recalculate recommendations.');
      _fetchLinkCrops(data);
    });
  }

  void _fetchLinkCrops(List<CropLink> crops) async {
    _cmsLinkLookup.clear();
    for (CropLink data in crops) {
      _cmsLinkLookup.putIfAbsent(data.cmsCropId, () => data);
    }
    _recalculate(await _userRepo.recommendationPreferenceSource.first);
  }

  void _subscribeToScoreUpdates() async {
    _cropScoreSub = _cropScoreRepo.createSubscription().listen((data) {
      print('Scores updated. recalculate recommendations.');
      _fetchCmsScores(data);
    });
  }

  void _fetchCmsCrops(List<CropCms> crops) async {
    _cmsCropLookup.clear();
    for (CropCms data in crops) {
      _cmsCropLookup.putIfAbsent(data.externalId, () => data);
    }
    _recalculate(await _userRepo.recommendationPreferenceSource.first);
  }

  void _fetchCmsScores(List<CropScore> scores) async {
    _cmsScoreLookup.clear();
    for (CropScore data in scores) {
      _cmsScoreLookup.putIfAbsent(data.crop, () => data);
    }
    _recalculate(await _userRepo.recommendationPreferenceSource.first);
  }

  void _publishRecommendationUpdates(List<RatedRecommendation> recommendations) {
    _ratedRecommendations.sink.add(recommendations);
  }
}

class RatedRecommendation {
  final String cropName;
  final String cmsCropId;
  final double score;

  RatedRecommendation({this.cmsCropId, this.cropName, this.score});
}

class RecommendationsBlocProvider extends BlocProvider<RecommendationsBloc> {
  RecommendationsBlocProvider({bloc, widget})
      : super(bloc: bloc, child: widget);
}
