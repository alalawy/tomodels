import 'arguments/create_json.dart';
import 'arguments/create_model.dart';
import 'arguments/init_config.dart';

void main(List<String> args) {
  if (args.length > 0) {
    if (args[0] == 'create') {
      if (args[1] == "models") {
        createModel();
      }
      if (args[1] == "json") {
        createJson();
      }

      if (args[1] == "all") {
        createJson();
        createModel();
      }
    }
    if (args[0] == 'init') {
      initConfig();
    }
  }
}
