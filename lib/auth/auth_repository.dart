import 'dart:convert';

import 'package:http/http.dart';
import 'package:science_art/model/models.dart';

class AuthRepository {
  Future<User> signUp({required String user, required String password}) async {
    String url = 'http://science-art.pro/signup.php';
    Response response = await post(Uri.parse(url), body: {'name': user});
    if (response.statusCode == 200) {
      if (response.body != 'null') {
        final User user = User.fromJson(json.decode(response.body));
        if (user.pass == password) {
          return user;
        } else {
          throw const FormatException('Неверный пароль');
        }
      } else {
        throw const FormatException('Неверный пользователь или пароль');
      }
    } else {
      throw FormatException(response.statusCode.toString());
    }
  }

  Future<User> signIn({
    required String email,
    required String password,
  }) async {
    try {} catch (e) {
      throw Exception('The password provided is too weak.');
    }
    return User();
  }

  Future<void> signOut() async {
    try {} catch (e) {
      throw Exception(e);
    }
  }
}
