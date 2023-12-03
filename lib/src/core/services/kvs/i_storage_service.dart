abstract interface class IStorageService {
  Future<String> getString(String key);
  Future<void> setString({required String value, required String key});
}
