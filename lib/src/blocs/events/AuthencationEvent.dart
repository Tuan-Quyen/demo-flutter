abstract class AuthencationEvent {}

class LoginEvent extends AuthencationEvent {
  final String userName;
  final String passWord;

  LoginEvent({this.userName, this.passWord})
      : assert(userName != null, passWord != null);
}
