import 'package:shared_preferences/shared_preferences.dart';
import 'package:usp_ecard/core/service/storage/i_storage_service.dart';

class StorageService implements IStorageService {
  final SharedPreferences sharedPreferences;
  StorageService({required this.sharedPreferences});

  @override
  Future<bool> clearData() async {
    return await sharedPreferences.clear();
  }

  @override
  Future<T> getData<T>({required String key}) async {
    return sharedPreferences.get(key) as T;
  }

  @override
  Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  @override
  Future<bool> saveData({required String key, required data}) async {
    if (data is String) {
      return await sharedPreferences.setString(key, data);
    }
    if (data is int) {
      return await sharedPreferences.setInt(key, data);
    }
    if (data is double) {
      return await sharedPreferences.setDouble(key, data);
    }
    if (data is bool) {
      return await sharedPreferences.setBool(key, data);
    }
    if (data is List<String>) {
      return await sharedPreferences.setStringList(key, data);
    }
    return false;
  }
}
