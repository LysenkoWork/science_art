import 'dart:convert';

import 'package:http/http.dart';
import 'package:science_art/model/models.dart';

class Reiting {
  String? id;
  String? ballov;

  Reiting({this.id, this.ballov});

  Reiting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ballov = json['ballov'];
  }
/*
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ballov'] = ballov;
  }
*/
}

class ReitingUser {
  String? cid;
  String? uid;
  String? ballov;

  ReitingUser({this.cid, this.uid, this.ballov});

  ReitingUser.fromJson(Map<String, dynamic> json) {
    cid = json['cid'];
    uid = json['uid'];
    ballov = json['ballov'];
  }
}

class AuthRepository {

  Future<Reiting> getReiting({required String id}) async {
    String url = 'http://science-art.pro/reiting.php';
    Response response = await post(Uri.parse(url), body: {'id': id});
    if (response.statusCode == 200) {
      if (response.body != 'null') {
        final Reiting reiting = Reiting.fromJson(json.decode(response.body));
        return reiting;
      }
    }
    return Reiting();
  }

  Future<ReitingUser> getReitingUser({required String cid, required String uid}) async {
    String url = 'http://science-art.pro/reitinguser.php';
    Response response = await post(Uri.parse(url), body: {'cid': cid, 'uid': uid});
    if (response.statusCode == 200) {
      if (response.body != 'null') {
        final ReitingUser reitinguser = ReitingUser.fromJson(json.decode(response.body));
        return reitinguser;
      }
    }
    return ReitingUser();
  }

  Future<void> addReiting({required String cid, required String uid, required String ballov}) async {
    String url = 'http://science-art.pro/addreiting.php';
    Response response = await post(Uri.parse(url), body: {'cid': cid, 'uid': uid, 'ballov': ballov});
    if (response.statusCode != 200) {
      }
  }

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



