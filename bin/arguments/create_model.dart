import 'dart:io';
import 'dart:isolate';
import 'package:process_run/shell.dart';
import 'json_to_dart.dart';

void createModel() async {
  var fileConfig = File('tomodels/config/config.dart');
  if (await fileConfig.exists()) {
    // var res = await FetchData().res();
    var _data = await fileConfig.readAsStringSync();
    final uri = Uri.dataFromString(
      '''
      import 'dart:isolate';

      void main(_, SendPort port) async{
        $_data
        port.send([jsonpath, endpoint, modelspath]);
      }
    ''',
      mimeType: 'application/dart',
    );

    var shell = Shell();

    final port = ReceivePort();
    await Isolate.spawnUri(uri, [], port.sendPort);

    List config = await port.first;

    List<Map<String, dynamic>> endpoint = config[1];
    endpoint.forEach((element) async {
      String name = element['name'];
      String jsonDir = config[0];
      String modelsDirectory = config[2];

      try {
        await shell.run('''
mkdir $modelsDirectory
''');
      } catch (e) {}

      await shell.run('''
touch $modelsDirectory/${name}_model.dart
''');

      var dataModels = File('$modelsDirectory/${name}_model.dart');

      if (await dataModels.exists()) {
        var _data =
            await dataModels.writeAsString(JsonToDart().data(jsonDir, name));
        print(await _data.exists());
      }
    });
  }
}
