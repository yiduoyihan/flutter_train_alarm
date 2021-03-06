// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:f_train_alarm/model/login/base_bean_entity.dart';
import 'package:f_train_alarm/generated/json/base_bean_entity_helper.dart';
import 'package:f_train_alarm/model/login/home_list_bean_entity.dart';
import 'package:f_train_alarm/generated/json/home_list_bean_entity_helper.dart';
import 'package:f_train_alarm/model/login/history_list_data_entity.dart';
import 'package:f_train_alarm/generated/json/history_list_data_entity_helper.dart';
import 'package:f_train_alarm/model/login/login_bean_entity.dart';
import 'package:f_train_alarm/generated/json/login_bean_entity_helper.dart';

class JsonConvert<T> {
	T fromJson(Map<String, dynamic> json) {
		return _getFromJson<T>(runtimeType, this, json);
	}

  Map<String, dynamic> toJson() {
		return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
    switch (type) {
			case BaseBeanEntity:
				return baseBeanEntityFromJson(data as BaseBeanEntity, json) as T;
			case HomeListBeanEntity:
				return homeListBeanEntityFromJson(data as HomeListBeanEntity, json) as T;
			case HomeListBeanData:
				return homeListBeanDataFromJson(data as HomeListBeanData, json) as T;
			case HistoryListDataEntity:
				return historyListDataEntityFromJson(data as HistoryListDataEntity, json) as T;
			case HistoryListDataData:
				return historyListDataDataFromJson(data as HistoryListDataData, json) as T;
			case LoginBeanEntity:
				return loginBeanEntityFromJson(data as LoginBeanEntity, json) as T;
			case LoginBeanData:
				return loginBeanDataFromJson(data as LoginBeanData, json) as T;
			case LoginBeanDataUserInfo:
				return loginBeanDataUserInfoFromJson(data as LoginBeanDataUserInfo, json) as T;    }
    return data as T;
  }

  static _getToJson<T>(Type type, data) {
		switch (type) {
			case BaseBeanEntity:
				return baseBeanEntityToJson(data as BaseBeanEntity);
			case HomeListBeanEntity:
				return homeListBeanEntityToJson(data as HomeListBeanEntity);
			case HomeListBeanData:
				return homeListBeanDataToJson(data as HomeListBeanData);
			case HistoryListDataEntity:
				return historyListDataEntityToJson(data as HistoryListDataEntity);
			case HistoryListDataData:
				return historyListDataDataToJson(data as HistoryListDataData);
			case LoginBeanEntity:
				return loginBeanEntityToJson(data as LoginBeanEntity);
			case LoginBeanData:
				return loginBeanDataToJson(data as LoginBeanData);
			case LoginBeanDataUserInfo:
				return loginBeanDataUserInfoToJson(data as LoginBeanDataUserInfo);
			}
			return data as T;
		}
  //Go back to a single instance by type
	static _fromJsonSingle<M>( json) {
		String type = M.toString();
		if(type == (BaseBeanEntity).toString()){
			return BaseBeanEntity().fromJson(json);
		}	else if(type == (HomeListBeanEntity).toString()){
			return HomeListBeanEntity().fromJson(json);
		}	else if(type == (HomeListBeanData).toString()){
			return HomeListBeanData().fromJson(json);
		}	else if(type == (HistoryListDataEntity).toString()){
			return HistoryListDataEntity().fromJson(json);
		}	else if(type == (HistoryListDataData).toString()){
			return HistoryListDataData().fromJson(json);
		}	else if(type == (LoginBeanEntity).toString()){
			return LoginBeanEntity().fromJson(json);
		}	else if(type == (LoginBeanData).toString()){
			return LoginBeanData().fromJson(json);
		}	else if(type == (LoginBeanDataUserInfo).toString()){
			return LoginBeanDataUserInfo().fromJson(json);
		}	
		return null;
	}

  //list is returned by type
	static M _getListChildType<M>(List data) {
		if(List<BaseBeanEntity>() is M){
			return data.map<BaseBeanEntity>((e) => BaseBeanEntity().fromJson(e)).toList() as M;
		}	else if(List<HomeListBeanEntity>() is M){
			return data.map<HomeListBeanEntity>((e) => HomeListBeanEntity().fromJson(e)).toList() as M;
		}	else if(List<HomeListBeanData>() is M){
			return data.map<HomeListBeanData>((e) => HomeListBeanData().fromJson(e)).toList() as M;
		}	else if(List<HistoryListDataEntity>() is M){
			return data.map<HistoryListDataEntity>((e) => HistoryListDataEntity().fromJson(e)).toList() as M;
		}	else if(List<HistoryListDataData>() is M){
			return data.map<HistoryListDataData>((e) => HistoryListDataData().fromJson(e)).toList() as M;
		}	else if(List<LoginBeanEntity>() is M){
			return data.map<LoginBeanEntity>((e) => LoginBeanEntity().fromJson(e)).toList() as M;
		}	else if(List<LoginBeanData>() is M){
			return data.map<LoginBeanData>((e) => LoginBeanData().fromJson(e)).toList() as M;
		}	else if(List<LoginBeanDataUserInfo>() is M){
			return data.map<LoginBeanDataUserInfo>((e) => LoginBeanDataUserInfo().fromJson(e)).toList() as M;
		}
		return null;
	}

  static M fromJsonAsT<M>(json) {
    if (json is List) {
      return _getListChildType<M>(json);
    } else {
      return _fromJsonSingle<M>(json) as M;
    }
  }
}