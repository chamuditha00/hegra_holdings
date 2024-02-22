class RegisterEmailPasswordFail {
  final String message;

  const RegisterEmailPasswordFail(
      [this.message =
          "An error occurred while registering the user. Please try again."]);
  factory RegisterEmailPasswordFail.code(String code) {
    switch (code) {
      case "email-already-in-use":
        return RegisterEmailPasswordFail(
            "The email address is already in use by another account.");
      case "invalid-email":
        return RegisterEmailPasswordFail(
            "The email address is badly formatted.");
      case "operation-not-allowed":
        return RegisterEmailPasswordFail(
            "Email & Password accounts are not enabled.");
      case "weak-password":
        return RegisterEmailPasswordFail("The password is too weak.");
      default:
        return RegisterEmailPasswordFail();
    }
  }
  @override
  String toString() {
    return message;
  }
}
