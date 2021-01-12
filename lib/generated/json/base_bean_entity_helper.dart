import 'package:f_train_alarm/model/login/base_bean_entity.dart';

baseBeanEntityFromJson(BaseBeanEntity data, Map<String, dynamic> json) {
	if (json['msg'] != null) {
		data.msg = json['msg'].toString();
	}
	if (json['code'] != null) {
		data.code = json['code'] is String
				? int.tryParse(json['code'])
				: json['code'].toInt();
	}
	return data;
}

Map<String, dynamic> baseBeanEntityToJson(BaseBeanEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['msg'] = entity.msg;
	data['code'] = entity.code;
	return data;
}