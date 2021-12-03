import 'package:mobile_app/src/services/user_service.dart';
import 'package:mocktail/mocktail.dart';

class MockUserService extends Mock implements UserService {
  @override
  Future<String> signUp(String email, String password) async {
    if (email == "quang235@gmail.com" && password == "Duongvanquang1@") {
      return 'sign-up-success';
    } else {
      return 'email-already-in-use';
    }
  }

  @override
  Future<String> signIn(String email, String password) async {
    if (email == 'username@email.com' && password == 'Aliba@123') {
      return 'login-success';
    } else if (email == 'user@email.com' && password.isNotEmpty) {
      return 'user-not-found';
    } else {
      return 'wrong-password';
    }
  }

  @override
  Future<String> resetPassword(String email) async {
    if (email == "bao.tdk2369@gmail.com") {
      return 'reset-password-requested';
    } else {
      return 'user-not-found';
    }
  }
}
