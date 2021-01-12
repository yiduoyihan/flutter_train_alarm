import 'package:f_train_alarm/model/login/history_list_data_entity.dart';

historyListDataEntityFromJson(HistoryListDataEntity data, Map<String, dynamic> json) {
	if (json['msg'] != null) {
		data.msg = json['msg'].toString();
	}
	if (json['code'] != null) {
		data.code = json['code'] is String
				? int.tryParse(json['code'])
				: json['code'].toInt();
	}
	if (json['data'] != null) {
		data.data = new List<HistoryListDataData>();
		(json['data'] as List).forEach((v) {
			data.data.add(new HistoryListDataData().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> historyListDataEntityToJson(HistoryListDataEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['msg'] = entity.msg;
	data['code'] = entity.code;
	if (entity.data != null) {
		data['data'] =  entity.data.map((v) => v.toJson()).toList();
	}
	return data;
}

historyListDataDataFromJson(HistoryListDataData data, Map<String, dynamic> json) {
	if (json['alarmInfoId'] != null) {
		data.alarmInfoId = json['alarmInfoId'] is String
				? int.tryParse(json['alarmInfoId'])
				: json['alarmInfoId'].toInt();
	}
	if (json['alarmContent'] != null) {
		data.alarmContent = json['alarmContent'].toString();
	}
	if (json['deviceNo'] != null) {
		data.deviceNo = json['deviceNo'].toString();
	}
	if (json['alarmReceiverId'] != null) {
		data.alarmReceiverId = json['alarmReceiverId'] is String
				? int.tryParse(json['alarmReceiverId'])
				: json['alarmReceiverId'].toInt();
	}
	if (json['alarmReceiverName'] != null) {
		data.alarmReceiverName = json['alarmReceiverName'].toString();
	}
	if (json['alarmMileage'] != null) {
		data.alarmMileage = json['alarmMileage'].toString();
	}
	if (json['longitude'] != null) {
		data.longitude = json['longitude'];
	}
	if (json['latitude'] != null) {
		data.latitude = json['latitude'];
	}
	if (json['createTime'] != null) {
		data.createTime = json['createTime'].toString();
	}
	if (json['callbackTime'] != null) {
		data.callbackTime = json['callbackTime'];
	}
	if (json['alarmCallback'] != null) {
		data.alarmCallback = json['alarmCallback'] is String
				? int.tryParse(json['alarmCallback'])
				: json['alarmCallback'].toInt();
	}
	if (json['remark'] != null) {
		data.remark = json['remark'];
	}
	if (json['spareColumn1'] != null) {
		data.spareColumn1 = json['spareColumn1'];
	}
	if (json['spareColumn2'] != null) {
		data.spareColumn2 = json['spareColumn2'];
	}
	if (json['spareColumn3'] != null) {
		data.spareColumn3 = json['spareColumn3'];
	}
	if (json['spareColumn4'] != null) {
		data.spareColumn4 = json['spareColumn4'];
	}
	if (json['spareColumn5'] != null) {
		data.spareColumn5 = json['spareColumn5'];
	}
	if (json['alarmLevel'] != null) {
		data.alarmLevel = json['alarmLevel'].toString();
	}
	if (json['deviceMileage'] != null) {
		data.deviceMileage = json['deviceMileage'].toString();
	}
	if (json['railwaylineId'] != null) {
		data.railwaylineId = json['railwaylineId'] is String
				? int.tryParse(json['railwaylineId'])
				: json['railwaylineId'].toInt();
	}
	if (json['railwaylineNo'] != null) {
		data.railwaylineNo = json['railwaylineNo'].toString();
	}
	if (json['deviceLongitude'] != null) {
		data.deviceLongitude = json['deviceLongitude'].toString();
	}
	if (json['deviceLatitude'] != null) {
		data.deviceLatitude = json['deviceLatitude'].toString();
	}
	if (json['alarmDistance'] != null) {
		data.alarmDistance = json['alarmDistance'].toString();
	}
	if (json['trainNo'] != null) {
		data.trainNo = json['trainNo'];
	}
	if (json['direction'] != null) {
		data.direction = json['direction'] is String
				? int.tryParse(json['direction'])
				: json['direction'].toInt();
	}
	if (json['directionName'] != null) {
		data.directionName = json['directionName'].toString();
	}
	if (json['delFlag'] != null) {
		data.delFlag = json['delFlag'] is String
				? int.tryParse(json['delFlag'])
				: json['delFlag'].toInt();
	}
	return data;
}

Map<String, dynamic> historyListDataDataToJson(HistoryListDataData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['alarmInfoId'] = entity.alarmInfoId;
	data['alarmContent'] = entity.alarmContent;
	data['deviceNo'] = entity.deviceNo;
	data['alarmReceiverId'] = entity.alarmReceiverId;
	data['alarmReceiverName'] = entity.alarmReceiverName;
	data['alarmMileage'] = entity.alarmMileage;
	data['longitude'] = entity.longitude;
	data['latitude'] = entity.latitude;
	data['createTime'] = entity.createTime;
	data['callbackTime'] = entity.callbackTime;
	data['alarmCallback'] = entity.alarmCallback;
	data['remark'] = entity.remark;
	data['spareColumn1'] = entity.spareColumn1;
	data['spareColumn2'] = entity.spareColumn2;
	data['spareColumn3'] = entity.spareColumn3;
	data['spareColumn4'] = entity.spareColumn4;
	data['spareColumn5'] = entity.spareColumn5;
	data['alarmLevel'] = entity.alarmLevel;
	data['deviceMileage'] = entity.deviceMileage;
	data['railwaylineId'] = entity.railwaylineId;
	data['railwaylineNo'] = entity.railwaylineNo;
	data['deviceLongitude'] = entity.deviceLongitude;
	data['deviceLatitude'] = entity.deviceLatitude;
	data['alarmDistance'] = entity.alarmDistance;
	data['trainNo'] = entity.trainNo;
	data['direction'] = entity.direction;
	data['directionName'] = entity.directionName;
	data['delFlag'] = entity.delFlag;
	return data;
}