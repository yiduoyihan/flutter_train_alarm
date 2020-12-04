import 'package:f_train_alarm/generated/json/base/json_convert_content.dart';

class LoginBeanEntity with JsonConvert<LoginBeanEntity> {
	String msg;
	int code;
	LoginBeanData data;
}

class LoginBeanData with JsonConvert<LoginBeanData> {
	LoginBeanDataUserInfo userInfo;
	String mpushServerIp;
	String token;
}

class LoginBeanDataUserInfo with JsonConvert<LoginBeanDataUserInfo> {
	int id;
	String createBy;
	String createTime;
	String lastUpdateBy;
	String lastUpdateTime;
	String employeeName;
	String userName;
	String password;
	String salt;
	String email;
	String mobile;
	int status;
	int deptId;
	dynamic deptName;
	int delFlag;
	String roleId;
	dynamic roleName;
}
