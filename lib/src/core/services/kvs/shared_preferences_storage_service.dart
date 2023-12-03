import 'package:shared_preferences/shared_preferences.dart';

import 'i_storage_service.dart';

class SharedPreferencesStorageService implements IStorageService {
  final SharedPreferences prefs;

  const SharedPreferencesStorageService(this.prefs);

  @override
  Future<String> getString(String key) async {
    return prefs.getString(key) ?? '';
  }

  @override
  Future<void> setString({required String value, required String key}) async {
    await prefs.setString(key, value);
  }
}
