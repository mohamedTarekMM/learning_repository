abstract class ChatLoginState{}
class InitChatLoginState extends ChatLoginState{}

class LoginGetSecureState extends ChatLoginState{}

class LoginUserLoadingState extends ChatLoginState{}
class LoginUserSuccessState extends ChatLoginState{
  final String uId;

  LoginUserSuccessState(this.uId);
}
class LoginUserErrorState extends ChatLoginState{
  final String error;

  LoginUserErrorState(this.error);
}