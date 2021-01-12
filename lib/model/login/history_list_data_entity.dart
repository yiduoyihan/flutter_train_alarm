import 'package:f_train_alarm/generated/json/base/json_convert_content.dart';

class HistoryListDataEntity with JsonConvert<HistoryListDataEntity> {
	String msg;
	int code;
	List<HistoryListDataData> data;
}

class HistoryListDataData with JsonConvert<HistoryListDataData> {
	int alarmInfoId;
	String alarmContent;
	String deviceNo;
	int alarmReceiverId;
	String alarmReceiverName;
	String alarmMileage;
	dynamic longitude;
	dynamic latitude;
	String createTime;
	dynamic callbackTime;
	int alarmCallback;
	dynamic remark;
	dynamic spareColumn1;
	dynamic spareColumn2;
	dynamic spareColumn3;
	dynamic spareColumn4;
	dynamic spareColumn5;
	String alarmLevel;
	String deviceMileage;
	int railwaylineId;
	String railwaylineNo;
	String deviceLongitude;
	String deviceLatitude;
	String alarmDistance;
	dynamic trainNo;
	int direction;
	String directionName;
	int delFlag;
}
