class UserModel {
  late String  name;
  late String  phone;
  late String  email;
  late String  uId;


  UserModel(
      {required this.name,
        required this.email,
        required this.phone,
        required this.uId,
       });
  UserModel.fromJson(Map<String,dynamic>json){
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    uId = json['uId'];

  }
  Map<String,dynamic>toMap(){
    return {
      'name':name,
      'phone':phone,
      'email':email,
      'uId':uId,
    };
  }

}
