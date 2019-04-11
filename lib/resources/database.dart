import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppDatabase {
  static final AppDatabase _appDatabase = AppDatabase._internal();

  // private constructor
  AppDatabase._internal();

  Firestore _database = Firestore.instance;

  static AppDatabase get() {
    // perhaps invoke additional initialisations
    return _appDatabase;
  }

  Query filteredCollection<T>({@required path, Map<String, String> filters}) {
    Query query =_database.collection(path);

    print('Creating query object for collection: $path');
    for(MapEntry<String, String> entry in filters?.entries ?? {}) {
      print(' + where ${entry.key} = ${entry.value}');
      query = query.where(entry.key, isEqualTo: entry.value);
    }

    return query;
  }

  Future<DocumentSnapshot> getDocument(path, id) {
    return _database.collection(path).document(id).get();
  }

}