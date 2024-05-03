abstract interface class IStorageService {
  Future<bool> saveData({required String key, required dynamic data});
  Future<T> getData<T>({required String key});
  Future<bool> removeData({required String key});
  Future<bool> clearData();
}
