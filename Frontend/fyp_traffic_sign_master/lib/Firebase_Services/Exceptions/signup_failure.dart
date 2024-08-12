
class SignUpWithEmailAndPassFailure implements Exception {
  
  final String message;
  const SignUpWithEmailAndPassFailure(
      [this.message = "An Unknown Error Occured."]);

  factory SignUpWithEmailAndPassFailure.code(String code) {
    switch (code) {
      case 'weak-password':
        return const SignUpWithEmailAndPassFailure(
            'Please enter a Stronger Password!');
      case 'invalid-email':
        return const SignUpWithEmailAndPassFailure('Email is not Valid !');
      case 'email-already-in-use':
        return const SignUpWithEmailAndPassFailure(
            'Account already exist. Check Email !');
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPassFailure(
            'Operation Not Allowed. Contact Support');
      case 'user-disabled':
        return const SignUpWithEmailAndPassFailure(
            'User Disabled. Contact Support');
      default:
        return const SignUpWithEmailAndPassFailure();
    }
  }
}
