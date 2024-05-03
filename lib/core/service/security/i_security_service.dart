import 'package:usp_ecard/core/models/user_model.dart';

abstract interface class ISecurityService {
  Future<bool> authenticate({required String password});
  Future<bool> isAuthenticated();
  Future<bool> getUser();
  Future<bool> saveUser({required UserModel user});
}
