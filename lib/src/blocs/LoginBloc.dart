import 'package:bloc/bloc.dart';
import 'package:flutter_app/src/blocs/states/AuthencationState.dart';
import 'package:flutter_app/src/models/AuthencationModels.dart';
import 'package:flutter_app/src/models/ErrorModels.dart';
import 'package:flutter_app/src/responsitory/UserResponsitory.dart';
import 'package:flutter_app/src/ultis/ValidateInput.dart';
import 'package:dio/dio.dart';
import 'events/AuthencationEvent.dart';

class UserBloc extends Bloc<AuthencationEvent, AuthencationState> {
  final UserResponsitory userResponsitory;

  UserBloc({this.userResponsitory}) : assert(userResponsitory != null);

  @override
  AuthencationState get initialState => LoginInitial();

  @override
  Stream<AuthencationState> mapEventToState(AuthencationEvent event) async* {
    if (event is LoginEvent) {
      yield LoginLoading();
      try {
        final AuthencationModels authencation =
            await userResponsitory.requestLogin(event.userName, event.passWord);
        yield LoginSuccess(authencationModels: authencation);
      } on DioError catch (error) {
        ErrorModels errorModels = ErrorModels.fromJson(error.response.data);
        print(errorModels.statusMessage);
        yield LoginFailure(error: errorModels.statusMessage);
        //yield LoginSuccess();
      }
    }
  }
}
