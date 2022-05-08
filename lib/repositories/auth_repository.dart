class AuthRepository {
  Future<bool> login(String email, String password) {
    if (email == 'test@gmail.com' && password == '123') {
      return Future.delayed(const Duration(seconds: 2), () => true);
    } else {
      return Future.delayed(const Duration(seconds: 2), () => false);
    }
  }
}
