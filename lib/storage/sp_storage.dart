import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

const String kGuessSpKey = 'guess-config';
const String kMuYUSpKey = 'muyu-config';

class SpStorage {
  // 单例模式
  SpStorage._(); // 私有化构造

  static SpStorage? _instance;
  // 提供实例对象的访问途径
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