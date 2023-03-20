import 'package:localstorage/localstorage.dart';

class LocalStorageProvider {
  static LocalStorage kawaLocalStorage = LocalStorage("kawa_app_storage");

  static Future<void> setObject(
      {required String key, required String value}) async {
    await kawaLocalStorage.ready;
    await kawaLocalStorage.setItem(key, value);
  }

  static Future<String?> getObject(String key) async {
    await kawaLocalStorage.ready;
    String? token = kawaLocalStorage.getItem(key);
    return token;
  }
}
