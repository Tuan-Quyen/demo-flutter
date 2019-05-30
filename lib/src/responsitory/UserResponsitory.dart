import 'package:flutter_app/src/models/AuthencationModels.dart';
import 'package:flutter_app/src/provider/AuthencationProvider.dart';

class UserResponsitory {
  AuthencationProvider _authencationProvider = AuthencationProvider();

  Future<AuthencationModels> requestLogin(String _userName, String _passWord) =>
      _authencationProvider.requestLogin(_userName, _passWord);
}
