import 'package:farmsmart/resources/database.dart';

class FactorsDB {
  static final FactorsDB _factorsDB = FactorsDB._internal(AppDatabase.get());

  AppDatabase database;

  // private internal constructor for singleton
  FactorsDB._internal(this.database);

  static FactorsDB get() {
    return _factorsDB;
  }

  List<String> locations = List<String>();
  List<String> landSize = List<String>();
  List<String> soilType = List<String>();
  List<String> irrigation = List<String>();
  List<String> season = List<String>();
  List<String> intention = List<String>();

  Future<List<String>> getLocations() async {
    // TODO: make this read from some other location ie firebase
    if (this.locations.length > 0) {
      return this.locations;
    }

    List<String> locations = List();
  
    locations.add('Baringo');
    locations.add('Bomet');
    locations.add('Bungoma');
    locations.add('Busia');
    locations.add('Elgeyo-Marakwet');
    locations.add('Embu');
    locations.add('Garissa');
    locations.add('Homa Bay');
    locations.add('Isiolo');
    locations.add('Kajiado');
    locations.add('Kakamega');
    locations.add('Kericho');
    locations.add('Kiambu');
    locations.add('Kilifi');
    locations.add('Kirinyaga');
    locations.add('Kisii');
    locations.add('Kisumu');
    locations.add('Kitui');
    locations.add('Kwale');
    locations.add('Laikipia');
    locations.add('Lamu');
    locations.add('Machakos');
    locations.add('Makueni');
    locations.add('Mandera');
    locations.add('Marsabit');
    locations.add('Meru');
    locations.add('Migori');
    locations.add('Mombasa');
    locations.add('Murang\'a');
    locations.add('Nairobi');
    locations.add('Nakuru');
    locations.add('Nandi');
    locations.add('Narok');
    locations.add('Nyamira');
    locations.add('Nyandarua');
    locations.add('Nyeri');
    locations.add('Samburu');
    locations.add('Siaya');
    locations.add('Taita–Taveta');
    locations.add('Tana River');
    locations.add('Tharaka-Nithi');
    locations.add('Trans-Nzoia');
    locations.add('Turkana');
    locations.add('Uasin Gishu');
    locations.add('Vihiga');
    locations.add('Wajir');
    locations.add('West Pokot');

    this.locations = locations;

    return this.locations;
  }

  Future<List<String>> getLandSize() async {
    // TODO: make this read from ie firebase
    if (this.landSize.length > 0) {
      return this.landSize;
    }

    List<String> landSize = List();

    landSize.add('Less than 10m2');
    landSize.add('Less than 1/4 acre');
    landSize.add('1/4 - 1/2 acre');
    landSize.add('1/2 - 1 acre');
    landSize.add('More than 1 acre');

    this.landSize = landSize;

    return this.landSize;
  }

  Future<List<String>> getSoilType() async {
    // TODO: make this read from ie firebase
    if (this.soilType.length > 0) {
      return this.soilType;
    }

    List<String> soilType = List();

    soilType.add('Sandy');
    soilType.add('Black cotton');
    soilType.add('Loamy');
    soilType.add('Alluvial');
    soilType.add('Volcanic');

    this.soilType = soilType;

    return this.soilType;
  }

  Future<List<String>> getIrrigation() async {
    // TODO: make this read from ie firebase
    if (this.irrigation.length > 0) {
      return this.irrigation;
    }

    List<String> irrigation = List();

    irrigation.add('Yes');
    irrigation.add('No');

    this.irrigation = irrigation;

    return this.irrigation;
  }

  Future<List<String>> getSeason() async {
    // TODO: make this read from ie firebase
    if (this.season.length > 0) {
      return this.season;
    }

    List<String> season = List();

    season.add('Short Rains');
    season.add('Long Rains');
    season.add('Dry');

    this.season = season;

    return this.season;
  }

  Future<List<String>> getIntention() async {
    // TODO: make this read from ie firebase
    if (this.intention.length > 0) {
      return this.intention;
    }

    List<String> intention = List();

    intention.add('Sales');
    intention.add('Subsistence');
    intention.add('Both');

    this.intention = intention;

    return this.intention;
  }


}