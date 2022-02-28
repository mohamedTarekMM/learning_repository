import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wether_app/models/chatModels/messageModel.dart';
import 'package:wether_app/models/chatModels/userModel.dart';

import '../../../shared/constants.dart';
import 'chat_state.dart';

class ChatLayoutsCubit extends Cubit<ChatLayoutsState> {
  ChatLayoutsCubit() : super(InitChatLayoutsState());
  UserModel? userModel;
  List<MessageModel>? message;

  static ChatLayoutsCubit get(context) => BlocProvider.of(context);

  sendMessage({
    required String text,
    required String dateTime,
    required String receiverId
  }) {
    MessageModel messageModel =
        MessageModel(senderId: uId,receiverId: receiverId,text: text, dateTime: dateTime);
    FirebaseFirestore.instance
        .collection('chats')
        .add(messageModel.toMap())
        .then((value) {
      emit(LayoutsSendMessageSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(LayoutsSendMessageErrorState(error.toString()));
    });
  }

  getMessage() {
    FirebaseFirestore.instance
        .collection('chats')
        .orderBy('dateTime' ,descending: true)
        .snapshots()
        .listen((event) {
      message = [];
      event.docs.forEach((element) {
        message!.add(MessageModel.fromJson(element.data()));
      });
      emit(LayoutsGetMessageSuccessState());
    });
  }
}
