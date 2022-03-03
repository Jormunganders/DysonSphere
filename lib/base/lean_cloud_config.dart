import 'package:flutter_dotenv/flutter_dotenv.dart';

class LeanCloudConfig {
  static String get appId => dotenv.get("APP_ID", fallback: "");

  static String get appKey => dotenv.get("APP_KEY", fallback: "");

  static String get server => dotenv.get("LEAN_CLOUD_SERVER", fallback: "");

  static bool isValid() {
    return appId.isNotEmpty && appKey.isNotEmpty && server.isNotEmpty;
  }
}
