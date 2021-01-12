import 'package:f_train_alarm/model/login/home_list_bean_entity.dart';

homeListBeanEntityFromJson(HomeListBeanEntity data, Map<String, dynamic> json) {
	if (json['msg'] != null) {
		data.msg = json['msg'].toString();
	}
	if (json['code'] != null) {
		data.code = json['code'] is String
				? int.tryParse(json['code'])
				: json['code'].toInt();
	}
	if (json['data'] != null) {
		data.data = new List<HomeListBeanData>();
		(json['data'] as List).forEach((v) {
			data.data.add(new HomeListBeanData().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> homeListBeanEntityToJson(HomeListBeanEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['msg'] = entity.msg;
	data['code'] = entity.code;
	if (entity.data != null) {
		data['data'] =  entity.data.map((v) => v.toJson()).toList();
	}
	return data;
}

homeListBeanDataFromJson(HomeListBeanData data, Map<String, dynamic> json) {
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
		data.lastUpdateBy = json['lastUpdateBy'];
	}
	if (json['lastUpdateTime'] != null) {
		data.lastUpdateTime = json['lastUpdateTime'];
	}
	if (json['noticeTitle'] != null) {
		data.noticeTitle = json['noticeTitle'].toString();
	}
	if (json['noticeType'] != null) {
		data.noticeType = json['noticeType'];
	}
	if (json['noticeContent'] != null) {
		data.noticeContent = json['noticeContent'].toString();
	}
	if (json['delFlag'] != null) {
		data.delFlag = json['delFlag'] is String
				? int.tryParse(json['delFlag'])
				: json['delFlag'].toInt();
	}
	if (json['status'] != null) {
		data.status = json['status'] is String
				? int.tryParse(json['status'])
				: json['status'].toInt();
	}
	if (json['remark'] != null) {
		data.remark = json['remark'];
	}
	if (json['roleId'] != null) {
		data.roleId = json['roleId'] is String
				? int.tryParse(json['roleId'])
				: json['roleId'].toInt();
	}
	if (json['deptId'] != null) {
		data.deptId = json['deptId'] is String
				? int.tryParse(json['deptId'])
				: json['deptId'].toInt();
	}
	if (json['roleName'] != null) {
		data.roleName = json['roleName'].toString();
	}
	if (json['deptName'] != null) {
		data.deptName = json['deptName'].toString();
	}
	return data;
}

Map<String, dynamic> homeListBeanDataToJson(HomeListBeanData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['createBy'] = entity.createBy;
	data['createTime'] = entity.createTime;
	data['lastUpdateBy'] = entity.lastUpdateBy;
	data['lastUpdateTime'] = entity.lastUpdateTime;
	data['noticeTitle'] = entity.noticeTitle;
	data['noticeType'] = entity.noticeType;
	data['noticeContent'] = entity.noticeContent;
	data['delFlag'] = entity.delFlag;
	data['status'] = entity.status;
	data['remark'] = entity.remark;
	data['roleId'] = entity.roleId;
	data['deptId'] = entity.deptId;
	data['roleName'] = entity.roleName;
	data['deptName'] = entity.deptName;
	return data;
}