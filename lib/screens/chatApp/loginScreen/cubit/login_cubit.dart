import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wether_app/screens/chatApp/loginScreen/cubit/chat_login_state.dart';

class ChatLoginCubit extends Cubit<ChatLoginState> {
  ChatLoginCubit() : super(InitChatLoginState());

  static ChatLoginCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;

  getVisible() {
    isPassword = !isPassword;
    emit(LoginGetSecureState());
  }

  getLoginUser({required String email, required String password}) {
    emit(LoginUserLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
          emit(LoginUserSuccessState(value.user!.uid));
    })
        .catchError((error) {
          print(error.toString());
      emit(LoginUserErrorState(error.toString()));
    });
  }
}
