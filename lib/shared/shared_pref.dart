import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{
 static SharedPreferences ? preferences;
 static sharedInit()async{
   return  preferences = await SharedPreferences.getInstance();
 }
 static Future<dynamic> saveShopData({
  required String key,
   required dynamic value
}) async {
    if(value is String)return await preferences!.setString(key, value);
    if(value is int)return await preferences!.setInt(key, value);
    if(value is bool)return await preferences!.setBool(key, value);
    return await preferences!.setDouble(key, value);
 }
 static dynamic getData({required String key}){
   return preferences!.get(key);
 }

 static Future<bool> removeData({
   required String key,
}) async {
  return await preferences!.remove(key);
 }
}