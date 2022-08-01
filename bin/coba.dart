import 'dart:io';
import 'dart:isolate';

import 'package:process_run/shell.dart';

void main({name}) async {
  var fileConfig = File('tomodels/config/config.dart');
  if (await fileConfig.exists()) {
    // var res = await FetchData().res();
    var _data = await fileConfig.readAsStringSync();
    final uri = Uri.dataFromString(
      '''
      import 'dart:isolate';

      void main(_, SendPort port) async{
        $_data
        port.send([jsonpath, endpoint]);
      }
    ''',
      mimeType: 'application/dart',
    );

    final port = ReceivePort();
    await Isolate.spawnUri(uri, [], port.sendPort);

    List config = await port.first;

    print(config);

    List<Map<String, dynamic>> endpoint = config[1];

    var shell = Shell();
    String jsonDirectory = config[0];
    try {
      await shell.run('''
          mkdir $jsonDirectory
        ''');
    } catch (e) {}
    await shell.run('''touch $jsonDirectory/$name.json''');

    var dataJson = File('\$jsonDirectory/$name.json');
    if (await dataJson.exists()) {
      // var res = await FetchData().res();
      // var _data =
      //     await dataJson.writeAsString(json.encode(res.data[0]).toString());
      // print(await _data.exists());
    }
  }
}
