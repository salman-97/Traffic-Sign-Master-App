import 'package:firebase_auth/firebase_auth.dart';

class LoginWithEmailAndPassFailure implements Exception {
  final String message;

  const LoginWithEmailAndPassFailure([this.message = "An Unknown Error Occurred."]);
  bool get isNoInternetCon => message.contains('ALERT ! No Internet Connection');

  factory LoginWithEmailAndPassFailure.code(FirebaseAuthException e) {
    switch (e.code) {
      case 'INVALID_LOGIN_CREDENTIALS':
        return const LoginWithEmailAndPassFailure('Invalid Email or Password');
      case 'invalid-email':
        return const LoginWithEmailAndPassFailure('Invalid Email Format');
      case 'user-not-found':
        return const LoginWithEmailAndPassFailure('Account does not exist');
      case 'wrong-password':
        return const LoginWithEmailAndPassFailure('Incorrect or Wrong Password');
      case 'no-internet-connection':
        return const LoginWithEmailAndPassFailure('ALERT ! No Internet Connection');
      default:
        return const LoginWithEmailAndPassFailure();
    }
  }
}

