import 'package:shared_preferences/shared_preferences.dart';

import 'i_storage_service.dart';

class SharedPreferencesStorageService implements IStorageService {
  const SharedPreferencesStorageService();

  @override
  Future<String> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }

  @override
  Future<void> setString({required String value, required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }
}
