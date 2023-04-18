class LoginWithEmailAndPasswordFailure {
  final String msg;

  const LoginWithEmailAndPasswordFailure(
      [this.msg = "An Unknown error occurred"]);

  factory LoginWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'user-not-found':
        return const LoginWithEmailAndPasswordFailure(
            'User not found! Please Sign Up.');
      case 'wrong-password':
        return const LoginWithEmailAndPasswordFailure(
            'Wrong password! Please try again.');
      case 'invalid-email':
        return const LoginWithEmailAndPasswordFailure(
            'Email is not valid or badly formatted.');
      case 'user-disabled':
        return const LoginWithEmailAndPasswordFailure(
            'This user has been disbled. Please contact support for help.');
      default:
        return const LoginWithEmailAndPasswordFailure();
    }
  }
}
