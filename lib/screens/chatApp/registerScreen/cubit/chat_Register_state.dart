abstract class ChatRegisterState{}
class InitChatRegisterState extends ChatRegisterState{}

class RegisterGetSecureState extends ChatRegisterState{}

class RegisterUserLoadingState extends ChatRegisterState{}
class RegisterUserSuccessfullyState extends ChatRegisterState{
  final String uId;

  RegisterUserSuccessfullyState(this.uId);
}
class RegisterUserErrorState extends ChatRegisterState{
  final String error;

  RegisterUserErrorState(this.error);
}

class RegisterCreateUserLoadingState extends ChatRegisterState{}
class RegisterCreateUserSuccessfullyState extends ChatRegisterState{
  final String uId;

  RegisterCreateUserSuccessfullyState(this.uId);
}
class RegisterCreateUserErrorState extends ChatRegisterState{
  final String error;

  RegisterCreateUserErrorState(this.error);
}