import 'dart:core';

class CropLink {
  String cmsCropId;
  String crop;

  CropLink.fromJSON(Map<String, dynamic> link) {
    this.cmsCropId = link['cmsCropId'];
    this.crop = link['crop'];
  }
}

class CropScore {
  Map<String, Map<String, int>> ratingLoopkup = Map<String, Map<String, int>>();
  Map<String, double> weights = Map<String, double>();
  Map<String, double> percentage = Map<String, double>();
  String crop;

  CropScore.fromJSON(Map<String, dynamic> cropScore) {


    crop = cropScore['crop']['title'];

    for(Map<dynamic, dynamic> each in cropScore['scores']) {
      String factor = each['factor'];

      double percentValue = each['percentage'];
      percentage.putIfAbsent(factor,() => percentValue);

      Map<String, int> valueLookup = Map<String, int>();
      for(dynamic pair in each['values']) {
        valueLookup.putIfAbsent(pair['key'], () => pair['rating'] ?? 0);
      }
      ratingLoopkup.putIfAbsent(factor,() =>  valueLookup);
    }

    print(this);
  }

  @override
  String toString() {
    return 'CropScore{crop: $crop, ratingLoopkup: $ratingLoopkup, percentage: $percentage, }';
  }

  double calculate(Map<String, String> factorValues) {

    double runScore = 0;

    for(MapEntry<String, String> each in factorValues.entries) {
      String factor = each.key;
      String valueKey = each.value;

      // rating bet 1 to 10
      int rating = ((ratingLoopkup[factor] ?? {})[valueKey] ?? 0);
      runScore += (rating / 10.0) * (percentage[factor]?? 0.0);
    }

    print(' * $crop = ${runScore.toStringAsPrecision(2)} - $factorValues');

    return runScore;
  }
}

class CropCms {
  String name;
  String type;
  String externalId;

  CropCms.fromJSON(Map<String, dynamic> cms) {
    name = cms['name'];
    type = cms['cropType'];
    externalId = cms['id'];
  }
}

class CropCmsDetailed extends CropCms{
  String summary;

  CropCmsDetailed.fromJSON(Map<String, dynamic> cms) : super.fromJSON(cms) {
    summary = cms['summary'];
  }
}