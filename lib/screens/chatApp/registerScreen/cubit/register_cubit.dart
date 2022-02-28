import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wether_app/models/chatModels/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat_Register_state.dart';

class ChatRegisterCubit extends Cubit<ChatRegisterState> {
  ChatRegisterCubit() : super(InitChatRegisterState());

  static ChatRegisterCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;

  getVisible() {
    isPassword = !isPassword;
    emit(RegisterGetSecureState());
  }

  getRegisterUser({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) {
    emit(RegisterUserLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
          getUserCreate(name: name, phone: phone, email: email, uId: value.user!.uid);
          emit(RegisterUserSuccessfullyState(value.user!.uid));
    })
        .catchError((error) {
          print(error.toString());
      emit(RegisterUserErrorState(error.toString()));

    });
  }

  getUserCreate({
    required String name,
    required String phone,
    required String email,
    required String uId,
  }){
   UserModel userModel = UserModel(name: name, email: email, phone: phone, uId: uId);
  FirebaseFirestore.instance.collection('users').doc(uId).set(userModel.toMap()).then((value) {
    emit(RegisterCreateUserSuccessfullyState(uId));
  }).catchError((error){
    print(error.toString());
    emit(RegisterCreateUserErrorState(error.toString()));
  });
  }
}
