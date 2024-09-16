import 'package:bloc_cubit/data/model/user_model.dart';
import 'package:bloc_cubit/data/provider/user_provider.dart';

abstract class IUserRepository {
  Future<UserModel> getUsers();
}

class UserRepository extends IUserRepository {
  final UserProvider userProvider;

  UserRepository({required this.userProvider});
  @override
  Future<UserModel> getUsers() {
    return userProvider.getUsers();
  }
}
