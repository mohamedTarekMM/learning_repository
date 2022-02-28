abstract class ChatLayoutsState{}
class InitChatLayoutsState extends ChatLayoutsState{}

class LayoutsGetSecureState extends ChatLayoutsState{}

class LayoutsSendMessageSuccessState extends ChatLayoutsState{}
class LayoutsSendMessageErrorState extends ChatLayoutsState{
  final String error;

  LayoutsSendMessageErrorState(this.error);
}
class LayoutsGetMessageSuccessState extends ChatLayoutsState{}
