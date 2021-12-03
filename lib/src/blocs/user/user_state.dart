import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserFullNameSubmitFailure extends UserState {}

class UserEmailSubmitFailure extends UserState {}

class UserEmailSubmitSuccess extends UserState {}

class UserPasswordSubmitFailure extends UserState {}

class UserLoginSuccess extends UserState {}

class UserSignUpSuccess extends UserState {}

class UserResetPasswordSuccess extends UserState {}

class UserAuthFailure extends UserState {
  final exception;
  UserAuthFailure(this.exception);
  @override
  List<Object> get props => [exception];
}
