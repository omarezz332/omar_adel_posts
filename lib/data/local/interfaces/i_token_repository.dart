abstract class ITokenRepository {
  Future<String> getToken();
  Future<void> deleteToken();
  Future<void> setToken(String newToken);
}
