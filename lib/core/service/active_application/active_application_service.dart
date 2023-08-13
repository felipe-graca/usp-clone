import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:usp_ecard/core/service/active_application/active_application_service_interface.dart';

class ActivationService implements IActiveApplicationService {
  final SharedPreferences _sharedPreference;
  ActivationService(this._sharedPreference);

  @override
  Future<bool> activeApplication(String activationKey) async =>
      await _getAplicationsKey().then((keys) async => keys.contains(activationKey) ? await _active(activationKey) : false).catchError((_) => false);

  @override
  Future<bool> isActivated() async {
    return await _getActiveKey().then((key) => key.isNotEmpty).catchError((_) => false);
  }

  Future<List<String>> _getAplicationsKey() async {
    const base64Keys = String.fromEnvironment("BASE64KEYS");

    if (base64Keys.isEmpty) {
      return [];
    }

    return await _base64ToList(base64Keys);
  }

  Future<List<String>> _base64ToList(String base64Keys) async {
    final bytes = base64Decode(base64Keys);
    final String keys = utf8.decode(bytes);

    final List<String> list = keys.split(",");

    return list;
  }

  Future<bool> _active(String key) async => await _sharedPreference.setString('key', key).then((value) => true).catchError((_) => false);

  Future<String> _getActiveKey() async => _sharedPreference.getString('key') ?? "";
}
