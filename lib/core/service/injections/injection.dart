import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:usp_ecard/core/service/security/i_security_service.dart';
import 'package:usp_ecard/core/service/security/security_service.dart';
import 'package:usp_ecard/core/service/storage/i_storage_service.dart';
import 'package:usp_ecard/core/service/storage/storage_service.dart';

class Injections {
  Injections._();

  static Future<void> start() async {
    final i = GetIt.instance;

    i.registerSingleton(await SharedPreferences.getInstance());

    i.registerLazySingleton<IStorageService>(() => StorageService(sharedPreferences: i.get()));

    i.registerLazySingleton<ISecurityService>(() => SecurityService(storageService: i.get()));
  }
}
