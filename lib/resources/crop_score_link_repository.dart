
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart/models/crop_score_model.dart';
import 'package:farmsmart/resources/database.dart';

class CropLinkRepository {

  static final String _scoreLink = 'fs_crop_score_cms_link';

  AppDatabase _db = AppDatabase.get();
  String env;
  String locale;

  Query _cropLinkQuery;

  CropLinkRepository({this.env: 'production', this.locale: 'en-US'}) {
    print('Connecting to firesore for $_scoreLink');

    _cropLinkQuery = _db.filteredCollection(path: _scoreLink, filters: {
      'env' : this.env,
      'locale' : this.locale});
  }

  Stream<List<CropLink>> createSubscription() {
    return _cropLinkQuery.snapshots().map(_convertIntoModel);
  }

  Future<List<CropLink>> fetchData() {
    return _cropLinkQuery.getDocuments().then(_convertIntoModel);
  }

  List<CropLink>_convertIntoModel(QuerySnapshot snap) {
    List<CropLink> data = List<CropLink>();

    for (DocumentSnapshot change in snap.documents) {
      data.add(CropLink.fromJSON(change.data));
    }

    return data;
  }

  void close() {

  }

}
