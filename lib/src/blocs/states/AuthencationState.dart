import 'package:flutter_app/src/models/AuthencationModels.dart';

abstract class AuthencationState {}

class LoginInitial extends AuthencationState {}

class LoginLoading extends AuthencationState {}

class LoginFailure extends AuthencationState {
  final String error;

  LoginFailure({this.error});
}

class LoginSuccess extends AuthencationState {
  final AuthencationModels authencationModels;

  LoginSuccess({this.authencationModels});
}
