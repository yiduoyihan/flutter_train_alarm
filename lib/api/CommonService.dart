import 'package:dio/dio.dart';
import 'package:f_train_alarm/model/login/base_bean_entity.dart';
import 'package:f_train_alarm/model/login/login_bean_entity.dart';
import 'package:f_train_alarm/model/login/home_list_bean_entity.dart';

import 'Api.dart';

class CommonService {
  // void startLogin(Function callback) async {
  //   Dio().post(Api.LOGIN, options: _getOptions()).then((response) {
  //     callback(LoginBeanEntity().fromJson(response.data));
  //   });
  // }

  ///登录
  Future<Response> login(String username, String password, String deviceNo,
      String latitude, String longitude, Function callback) async {
    FormData formData = new FormData.fromMap({
      "username": "$username",
      "password": "$password",
      "deviceNo": "$deviceNo",
      "latitude": "$latitude",
      "longitude": "$longitude",
    });
    return Dio().post(Api.LOGIN, data: formData).then((response) {
      print(response.data);
      return callback(LoginBeanEntity().fromJson(response.data));
    });
  }

  ///退出登录
  Future<Response> outLogin(
      String token, String deviceNo, Function callback) async {
    FormData formData = new FormData.fromMap({
      "token": "$token",
      "deviceNo": "$deviceNo",
    });
    return Dio().post(Api.LOGIN_OUT, data: formData).then((response) {
      print(response.data);
      return callback(BaseBeanEntity().fromJson(response.data));
    });
  }

  ///退出登录
  Future<Response> changePwd(String token, String deviceNo, String userId,
      String pwd, String newPwd, String newPwdAgain, Function callback) async {
    FormData formData = new FormData.fromMap({
      "token": "$token",
      "deviceNo": "$deviceNo",
      "userId": "$userId",
      "password": "$pwd",
      "newPassword": "$newPwd",
      "confirmPassword": "$newPwdAgain",
    });
    return Dio().post(Api.CHANGE_PWD, data: formData).then((response) {
      print(response.data);
      return callback(BaseBeanEntity().fromJson(response.data));
    });
  }

  ///按日期查询公告列表
  Future<Response> getNoticeList(String token, String deviceNo, int pageSize,
      int pageNum, String startTime, String endTime, Function callback) async {

    Map<String ,dynamic> map  = new Map();
    map["token"]= token;
    map["deviceNo"]= deviceNo;
    map["pageSize"]= pageSize;
    map["pageNum"]= pageNum;
    map["startTime"]= startTime;
    map["endTime"]= endTime;

    return Dio().get(Api.HOME_LIST,queryParameters: map).then((response) {
      print(response.data);
      return callback(HomeListBeanEntity().fromJson(response.data));
    });
  }

  Options _getOptions() {
    return Options();
  }
}
