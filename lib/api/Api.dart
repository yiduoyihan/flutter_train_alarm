
class Api {

 static final String BASE_URL = "http://192.168.8.26:8002/";
//    public static String baseUrl = "http://123.138.236.26:8002/";

 static final String LOGIN = BASE_URL+"app/login";
 static final String LOGIN_OUT = BASE_URL+"app/logout";
 static final String CHANGE_PWD = BASE_URL+"app/user/changePassword";
 static final String UPLOAD_LOCATION = BASE_URL+"app/track/uploadPoint";
 static final String UPLOAD_HISTORY_LOCATION = BASE_URL+"app/track/uploadHistoricalPoint";
 static final String NOTIFICATION_LIST = BASE_URL+"app/alarmInfo/getList";
 static final String DELETE_NOTIFICATION_ITEM = BASE_URL+"/app/alarmInfo/deleteAlarm";
 static final String HOME_LIST = BASE_URL+"/app/notice/getList";
 static final String GET_ALL_USER = BASE_URL+"/app/user/getAllUserLabel";
 static final String GET_TRACK = BASE_URL+"/app/track/g96-+etTrackList";
 static final String DELETE_HOME_ITEM = "";
 static final String GET_RAILWAY = BASE_URL+"/app/railwayline/getAllRailwayline";
 static final String GET_ALARMSET = BASE_URL+"/app/alarmSet/getPersonAlarmSetList";
 static final String CALL_BACK_ALARM = BASE_URL+"/app/alarmInfo/callbackAlarm";

}