import 'dart:io';

import 'package:process_run/shell.dart';

Future<void> initConfig() async {
  var shell = Shell();
  String configDir = "config";
  String maindir = "tomodels";

  try {
    await shell.run('''
mkdir $maindir
''');
  } catch (e) {}
  try {
    await shell.run('''
mkdir $maindir/$configDir
''');
  } catch (e) {}

  await shell.run('''
touch $maindir/$configDir/config.dart
''');

  var readConfig = File('$maindir/$configDir/config.dart');

  if (await readConfig.exists()) {
    var _data = await readConfig.writeAsString("""
String jsonpath = "$maindir/json";
List<Map<String, dynamic>> endpoint = [
  {
    "name": "",
    "url": "",
    "methods": "",
    "headers": {"Content-Type": "application/json"},
    "body": {}
  }
];
""");
    print(await _data.exists());
  }
}
