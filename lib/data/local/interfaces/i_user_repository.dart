
import '../../../models/core/user.dart';

abstract class IUserRepository {
  bool exist();
  UserData get();
  Future<void> set(UserData user);
  void delete();
}
