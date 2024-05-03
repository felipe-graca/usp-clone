abstract interface class ISecurityService {
  Future<bool> authenticate({required String password});
  Future<bool> isAuthenticated();
}
