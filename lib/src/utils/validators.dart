class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z.][a-zA-Z0-9_\.]{3,32}@[a-zA-Z]{2,}(\.[a-zA-Z]{2,4}){1,2}$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[\W]).{8,}$'
,
  );

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }
}
