import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wether_app/layout/chatApp/cubit/chat_cubit.dart';
import 'package:wether_app/layout/chatApp/cubit/chat_state.dart';
import 'package:wether_app/models/chatModels/messageModel.dart';
import 'package:wether_app/screens/chatApp/registerScreen/cubit/register_cubit.dart';
import 'package:wether_app/shared/components.dart';
import 'package:wether_app/shared/constants.dart';

class ChatAppLayoutScreen extends StatelessWidget {
  var messageController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocConsumer<ChatLayoutsCubit, ChatLayoutsState>(
        listener: (context, state) {
          if(state is LayoutsSendMessageSuccessState){
            defaultScrollToEnd(scrollController: _scrollController);
          }
        },
        builder: (context, state) {
          var message = ChatLayoutsCubit.get(context).message;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: MPRIMARYCOLORS,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/scholar.png',
                    width: 50,
                    height: 50,
                  ),
                  Text(
                    'Chat',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.white),
                  )
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  ConditionalBuilder(
                    condition: message != null,
                    builder: (context) => Expanded(
                        child: ListView.separated(
                          reverse: true,
                          controller: _scrollController,
                          physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        var message =
                            ChatLayoutsCubit.get(context).message![index];
                        if(message.receiverId == uId){
                          return myMessage(context, message);
                        }else{
                          return receiveMessage(context, message);
                        }
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: 5,
                      ),
                      itemCount: message!.length,
                    )),
                    fallback: (context) => Center(child: Container()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: defaultTextFormWithHintText(
                      controller: messageController,
                      keyboardType: TextInputType.text,
                      hintText: 'Write Your Message',
                      suffixIcon: Icons.send,
                      suffixPressed: () {
                        ChatLayoutsCubit.get(context).sendMessage(
                          receiverId: uId,
                            text: messageController.text,
                            dateTime: DateTime.now().toString());
                        messageController.clear();
                        defaultScrollToEnd(scrollController: _scrollController);
                      },
                      outlineInputBorder: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  Widget myMessage(context, MessageModel messageModel) => Align(
        alignment: Alignment.topRight,
        child: Container(
            padding: const EdgeInsetsDirectional.all(10),
            decoration: const BoxDecoration(
              color: Colors.indigoAccent,
              borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(10),
                  bottomEnd: Radius.circular(0),
                  bottomStart: Radius.circular(10),
                  topEnd: Radius.circular(10)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    messageModel.text,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ],
            )),
      );

  Widget receiveMessage(context, MessageModel messageModel) => Align(
        alignment: AlignmentDirectional.topStart,
        child: Container(
            padding: const EdgeInsetsDirectional.all(10),
            decoration: const BoxDecoration(
              color: MPRIMARYCOLORS,
              borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(10),
                  bottomEnd: Radius.circular(10),
                  topEnd: Radius.circular(10)),
            ),
            child: Text(
              messageModel.text,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.white),
            )),
      );
}
