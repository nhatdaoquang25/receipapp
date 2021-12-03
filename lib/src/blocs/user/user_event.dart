import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UserLoginButtonSubmitted extends UserEvent {
  final String email;
  final String password;
  UserLoginButtonSubmitted(this.email, this.password);
  @override
  List<Object> get props => [email, password];
}

class UserSignupButtonSubmitted extends UserEvent {
  final String email;
  final String password;
  final String fullName;
  UserSignupButtonSubmitted(this.email, this.password, this.fullName);
  @override
  List<Object> get props => [email, password, fullName];
}

class UserForgotPasswordSubmitted extends UserEvent {
  final String email;
  UserForgotPasswordSubmitted(this.email);
  @override
  List<Object> get props => [email];
}
