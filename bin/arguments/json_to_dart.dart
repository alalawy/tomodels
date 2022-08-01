import 'dart:io';
import 'package:tomodels/javiercbk/json_to_dart.dart';
import "package:path/path.dart" show dirname, join, normalize;

import '../utils/utils.dart';

class JsonToDart {
  String data(String filepath, String name) {
    String filePath = "$filepath/$name.json";
    final jsonRawData = new File(filePath).readAsStringSync();
    DartCode dartCode = ModelGenerator("Datum${name.toCapitalized()}")
        .generateDartClasses(jsonRawData);
    return dartCode.code;
  }
}
