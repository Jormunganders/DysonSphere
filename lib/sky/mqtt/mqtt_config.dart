import 'package:flutter_dotenv/flutter_dotenv.dart';

class MQTTConfig {
  static bool _initialized = false;
  static List<Function> actions = [];

  static void init() {
    serverUrl = dotenv.get("mqtt_server_url", fallback: "");
    port = int.parse(dotenv.get("mqtt_port", fallback: "0"));
    username = dotenv.get("mqtt_username", fallback: "");
    password = dotenv.get("mqtt_password", fallback: "");
    _initialized = true;
    actions.forEach((element) {
      element();
    });
  }

  static void waitInitialized(Function action) {
    if (_initialized) {
      action();
    } else {
      actions.add(action);
    }
  }

  static bool isInitialized() => _initialized;

  static String serverUrl = "";
  static int port = 0;
  static String username = "";
  static String password = "";
}
