import 'package:f_train_alarm/generated/json/base/json_convert_content.dart';

class HomeListBeanEntity with JsonConvert<HomeListBeanEntity> {
	String msg;
	int code;
	List<HomeListBeanData> data;
}

class HomeListBeanData with JsonConvert<HomeListBeanData> {
	int id;
	String createBy;
	String createTime;
	dynamic lastUpdateBy;
	dynamic lastUpdateTime;
	String noticeTitle;
	dynamic noticeType;
	String noticeContent;
	int delFlag;
	int status;
	dynamic remark;
	int roleId;
	int deptId;
	String roleName;
	String deptName;
}
