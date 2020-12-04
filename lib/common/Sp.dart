import 'package:shared_preferences/shared_preferences.dart';

class Sp {
  static put(String key, String value) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  // static getS(String key, Function callback) async {
  //   SharedPreferences.getInstance().then((prefs) {
  //     callback(prefs.getString(key));
  //   });
  // }

  static Future<String> getS(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     return sharedPreferences.getString(key);
  }

  static putIsLogin(String value) {
    put("islogin", value);
  }

  static putToken(String value) {
    put("token", value);
  }

  static putDeviceId(String value) {
    put("deviceId", value);
  }

  static putUserName(String value) {
    put("username", value);
  }

  static putPassword(String value) {
    put("password", value);
  }

  static getIsLogin() {
    getS("islogin");
  }

  static getToken() {
    getS("token");
  }

  static getUserName() {
    getS("username");
  }

  static getPassword() {
    getS("password");
  }

  static getDeviceId() {
    getS("deviceId");
  }

}
