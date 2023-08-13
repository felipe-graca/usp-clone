abstract interface class IActiveApplicationService {
  Future<bool> activeApplication(String activationKey);
  Future<bool> isActivated();
}
