class AuthRepository {

  Future<void> signUp({required String email, required String password}) async {
    try {

    } catch (e) {
      throw Exception('The password provided is too weak.');
    }
  }

  Future<void> signIn({required String email, required String password,}) async {
    try {

    } catch (e) {
      throw Exception('The password provided is too weak.');
    }
  }

  Future<void> signOut() async {
    try {

    } catch (e) {
      throw Exception(e);
    }
  }
}