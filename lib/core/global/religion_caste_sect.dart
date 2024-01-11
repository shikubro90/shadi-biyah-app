import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:matrimony/view/widget/religion_model/religion_model.dart';

class ReligionSectCaste {
  static ReligionModel religions = ReligionModel();
  static List<Caste> castes = [];
  static String casteSect = "";
  static Future<void> getReligions() async {
    var jsonString =
        await rootBundle.loadString('assets/religion/religions.json');
    religions = ReligionModel.fromJson(json.decode(jsonString));
  }
}
