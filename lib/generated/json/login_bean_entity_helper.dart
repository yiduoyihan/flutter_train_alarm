import 'package:f_train_alarm/model/login/login_bean_entity.dart';

loginBeanEntityFromJson(LoginBeanEntity data, Map<String, dynamic> json) {
	if (json['msg'] != null) {
		data.msg = json['msg'].toString();
	}
	if (json['code'] != null) {
		data.code = json['code'] is String
				? int.tryParse(json['code'])
				: json['code'].toInt();
	}
	if (json['data'] != null) {
		data.data = new LoginBeanData().fromJson(json['data']);
	}
	return data;
}

Map<String, dynamic> loginBeanEntityToJson(LoginBeanEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['msg'] = entity.msg;
	data['code'] = entity.code;
	if (entity.data != null) {
		data['data'] = entity.data.toJson();
	}
	return data;
}

loginBeanDataFromJson(LoginBeanData data, Map<String, dynamic> json) {
	if (json['userInfo'] != null) {
		data.userInfo = new LoginBeanDataUserInfo().fromJson(json['userInfo']);
	}
	if (json['mpushServerIp'] != null) {
		data.mpushServerIp = json['mpushServerIp'].toString();
	}
	if (json['token'] != null) {
		data.token = json['token'].toString();
	}
	return data;
}

Map<String, dynamic> loginBeanDataToJson(LoginBeanData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.userInfo != null) {
		data['userInfo'] = entity.userInfo.toJson();
	}
	data['mpushServerIp'] = entity.mpushServerIp;
	data['token'] = entity.token;
	return data;
}

loginBeanDataUserInfoFromJson(LoginBeanDataUserInfo data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['createBy'] != null) {
		data.createBy = json['createBy'].toString();
	}
	if (json['createTime'] != null) {
		data.createTime = json['createTime'].toString();
	}
	if (json['lastUpdateBy'] != null) {
		data.lastUpdateBy = json['lastUpdateBy'].toString();
	}
	if (json['lastUpdateTime'] != null) {
		data.lastUpdateTime = json['lastUpdateTime'].toString();
	}
	if (json['employeeName'] != null) {
		data.employeeName = json['employeeName'].toString();
	}
	if (json['userName'] != null) {
		data.userName = json['userName'].toString();
	}
	if (json['password'] != null) {
		data.password = json['password'].toString();
	}
	if (json['salt'] != null) {
		data.salt = json['salt'].toString();
	}
	if (json['email'] != null) {
		data.email = json['email'].toString();
	}
	if (json['mobile'] != null) {
		data.mobile = json['mobile'].toString();
	}
	if (json['status'] != null) {
		data.status = json['status'] is String
				? int.tryParse(json['status'])
				: json['status'].toInt();
	}
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['deptName'] != null) {
		data.deptName = json['deptName'];
	}
	if (json['delFlag'] != null) {
		data.delFlag = json['delFlag'] is String
				? int.tryParse(json['delFlag'])
				: json['delFlag'].toInt();
	}
	if (json['roleId'] != null) {
		data.roleId = json['roleId'].toString();
	}
	if (json['roleName'] != null) {
		data.roleName = json['roleName'];
	}
	return data;
}

Map<String, dynamic> loginBeanDataUserInfoToJson(LoginBeanDataUserInfo entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['createBy'] = entity.createBy;
	data['createTime'] = entity.createTime;
	data['lastUpdateBy'] = entity.lastUpdateBy;
	data['lastUpdateTime'] = entity.lastUpdateTime;
	data['employeeName'] = entity.employeeName;
	data['userName'] = entity.userName;
	data['password'] = entity.password;
	data['salt'] = entity.salt;
	data['email'] = entity.email;
	data['mobile'] = entity.mobile;
	data['status'] = entity.status;
	data['deptId'] = entity.deptId;
	data['deptName'] = entity.deptName;
	data['delFlag'] = entity.delFlag;
	data['roleId'] = entity.roleId;
	data['roleName'] = entity.roleName;
	return data;
}