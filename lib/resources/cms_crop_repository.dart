
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart/models/crop_score_model.dart';
import 'package:farmsmart/resources/database.dart';

class CropCmsRepository {

  static const String _collection = 'fl_content';
  static const String _cmsSchema = 'crop';
  static const String _published = 'PUBLISHED';

  AppDatabase _db = AppDatabase.get();
  String env;
  String locale;
  Query _cmsCropPublishedQuery;

  CropCmsRepository({this.env: 'production', this.locale: 'en-US'}) {
    print('Connecting to firesore for $_collection');

    _cmsCropPublishedQuery = _db.filteredCollection(path: _collection, filters : {
      '_fl_meta_.env' : this.env,
      '_fl_meta_.locale' : this.locale,
      '_fl_meta_.schema' : _cmsSchema,
      'status' : _published
    });
  }

  Stream<List<CropCms>> createSubscription() {
    return _cmsCropPublishedQuery.snapshots().map(_convertIntoModel);
  }

  List<CropCms>_convertIntoModel(QuerySnapshot snap) {
    List<CropCms> data = List<CropCms>();

    for (DocumentSnapshot change in snap.documents) {
      data.add(CropCms.fromJSON(change.data));
    }

    return data;
  }

  Future<CropCmsDetailed> fetchCropById(String id) {
    return _db.getDocument(_collection, id).then((snap){
      if (snap.exists) {
        return CropCmsDetailed.fromJSON(snap.data);
      } else {
        return null;
      }
    });
  }

  Future<List<CropCms>> fetchData() {
    return _cmsCropPublishedQuery.getDocuments().then((snap) async {
      return _convertIntoModel(snap);
    });
  }

  void close() {

  }
}
