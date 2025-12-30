import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;
  AuthSuccess(this.user);
}

class AuthFailure extends AuthState {
  final String error;
  AuthFailure(this.error);
}

class AuthLocked extends AuthState {
  final String recoveryKey;
  AuthLocked({this.recoveryKey = "111"});
}

class UserFetchSuccess extends AuthState {
  final Map<String, dynamic> userData;
  UserFetchSuccess(this.userData);
}

class UserFetchFailure extends AuthState {
  final String error;
  UserFetchFailure(this.error);
}
