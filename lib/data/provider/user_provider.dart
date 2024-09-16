import 'package:bloc_cubit/data/model/user_model.dart';
import 'package:dio/dio.dart';

class UserProvider {
  final Dio _dio = Dio(BaseOptions(baseUrl: "https://reqres.in/api/"));

  Future<UserModel> getUsers() async {
    try {
      final response = await _dio.get("users?page=1");
      return userModelFromJson(response.toString());
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
