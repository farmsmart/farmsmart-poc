
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart/models/crop_score_model.dart';
import 'package:farmsmart/resources/database.dart';

class CropScoreRepository {

  static final String _collection = 'fs_crop_scores';

  AppDatabase _db = AppDatabase.get();
  String env;
  String locale;

  Query _cropScoresQuery;

  CropScoreRepository() {
    print('Connecting to firesore for $_collection');

    _cropScoresQuery = _db.filteredCollection(path: _collection);
  }

  Stream<List<CropScore>> createSubscription() {
    return _cropScoresQuery.snapshots().map(_convertIntoModel);
  }

  List<CropScore>_convertIntoModel(QuerySnapshot snap) {
    List<CropScore> data = List<CropScore>();

    for (DocumentSnapshot change in snap.documents) {
      data.add(CropScore.fromJSON(change.data));
    }

    return data;
  }

  Future<List<CropScore>> fetchData() {
    return _cropScoresQuery.getDocuments().then((snap) async {
      return _convertIntoModel(snap);
    });
  }


  void close() {

  }

}
