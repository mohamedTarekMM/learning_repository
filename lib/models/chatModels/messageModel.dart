class MessageModel {
  late String  text;
  late String  dateTime;
  late String  receiverId;
  late String senderId;


  MessageModel(
      {required this.text,
        required this.receiverId,
        required this.dateTime,
         required this.senderId,
      });
  MessageModel.fromJson(Map<String,dynamic>json){
    text = json['text'];
    dateTime = json['dateTime'];
    receiverId = json['receiverId'];
    senderId = json['senderId'];

  }
  Map<String,dynamic>toMap(){
    return {
      'text':text,
      'dateTime':dateTime,
      'receiverId':receiverId,
      'senderId':senderId,
    };
  }

}
