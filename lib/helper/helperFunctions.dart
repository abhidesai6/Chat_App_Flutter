import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {

  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY" ;
  static String sharedPreferenceUserEmailKey = "USEREMAIL";
  static String sharedPreferenceUserUidKey = "USEREUID";

  //saving data to shared preference

  static Future<bool> saveUserLoggedInSharedPreference(bool isUserLoggedIn) async{
    SharedPreferences prefs = await SharedPreferences.getInstance() ;
    return await prefs.setBool(sharedPreferenceUserLoggedInKey,isUserLoggedIn);
  }

  static Future<bool> saveUserNameInSharedPreference(String userName) async{
    SharedPreferences prefs = await SharedPreferences.getInstance() ;
    return await prefs.setString(sharedPreferenceUserNameKey,userName);
  }

  static Future<bool> saveUserEmailInSharedPreference(String userEmail) async{
    SharedPreferences prefs = await SharedPreferences.getInstance() ;
    return await prefs.setString(sharedPreferenceUserEmailKey,userEmail);
  }

  static Future<bool> saveUserUidSharedPreference(String userUid) async{
    SharedPreferences prefs = await SharedPreferences.getInstance() ;
    return await prefs.setString(sharedPreferenceUserUidKey,userUid);
  }
  

  static Future<bool> getUserLoggedInSharedPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance() ;
    return await prefs.getBool(sharedPreferenceUserLoggedInKey);
  }

  static Future<String> getUserNameInSharedPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance() ;
    return await prefs.getString(sharedPreferenceUserNameKey);
  }

  static Future<String> getUserEmailInSharedPreference(String text) async{
    SharedPreferences prefs = await SharedPreferences.getInstance() ;
    return await prefs.getString(sharedPreferenceUserEmailKey);
  }

  static Future<String> getUserUidSharedPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance() ;
    return await prefs.getString(sharedPreferenceUserUidKey);
  }
  

  }
