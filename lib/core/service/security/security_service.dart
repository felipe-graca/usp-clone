import 'dart:convert';

import 'package:usp_ecard/core/models/user_model.dart';
import 'package:usp_ecard/core/service/security/i_security_service.dart';
import 'package:usp_ecard/core/service/storage/i_storage_service.dart';

class SecurityService implements ISecurityService {
  final IStorageService storageService;
  SecurityService({required this.storageService});

  String _getCurrentPassword() {
    return _encodeBase64(_getCurrentDateTime());
  }

  //current DateTime to passwrod access
  String _getCurrentDateTime() {
    return (DateTime.now().hour + DateTime.now().minute).toString();
  }

  //Encode String to Base64
  String _encodeBase64(String data) {
    const base64 = Base64Encoder();
    return base64.convert(data.codeUnits);
  }

  @override
  Future<bool> authenticate({required String password}) async {
    if (password == _getCurrentPassword()) {
      await storageService.saveData(key: 'actived', data: true);
      return true;
    }
    return false;
  }

  @override
  Future<bool> isAuthenticated() async => await storageService.getData<bool?>(key: 'actived') ?? false;

  @override
  Future<bool> getUser() async {
    final jsonUser = await storageService.getData<String?>(key: 'user') ?? '';

    if (jsonUser.isEmpty) return false;

    UserStore.instance.setUser(UserModel.fromJson(json.decode(jsonUser)));
    return true;
  }

  @override
  Future<bool> saveUser({required UserModel user}) async {
    final hasSavedUser = await storageService.saveData(key: 'user', data: json.encode(user.toJson()));

    if (hasSavedUser) {
      UserStore.instance.setUser(user);
      return true;
    }
    return false;
  }
}

class UserStore {
  UserStore._();

  static final UserStore instance = UserStore._();

  UserModel _user = const UserModel();

  UserModel get user => _user;

  void setUser(UserModel user) {
    _user = user;
  }
}
