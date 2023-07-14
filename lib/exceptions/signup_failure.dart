class SignUpWithEmailAndPasswordFailure {
  final String msg;

  const SignUpWithEmailAndPasswordFailure(
      [this.msg = "An Unknown error occurred"]);

  factory SignUpWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
            'Weak Password. Your password should be at least 6 characters.');
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
            'Email is not valid or badly formatted.');
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
            'The email address is already in use by another account.');
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
            'Operation is not allowed. Please contact support.');
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
            'This user has been disbled. Please contact support for help.');
      case 'session-cookie-expired':
        return const SignUpWithEmailAndPasswordFailure(
            'The provided Firebase session cookie is expired.');
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
}
