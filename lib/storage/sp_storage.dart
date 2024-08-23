import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

const String kGuessSpKey = 'guess-config';
const String kMuYUSpKey = 'muyu-config';

class SpStorage {
  SpStorage._();

  static SpStorage? _instance;
  static SpStorage get instance => _instance ??= SpStorage._();

  SharedPreferences? _sp;

  Future<void> initSpWhenNull() async {
    _sp ??= await SharedPreferences.getInstance();
  }

  Future<bool> saveMuYUConfig({
    required int counter,
    required int activeImageIndex,
    required int activeAudioIndex,
  }) async {
    await initSpWhenNull();
    String content = json.encode({
      'counter': counter,
      'activeImageIndex': activeImageIndex,
      'activeAudioIndex': activeAudioIndex,
    });

    return _sp!.setString(kMuYUSpKey, content);
  }

  Future<Map<String, dynamic>> readMuYUConfig() async {
    await initSpWhenNull();
    String? content = _sp!.getString(kMuYUSpKey);
    if (content == null) {
      return {};
    }
    return json.decode(content);
  }
}