import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:xml2json/xml2json.dart';
import './sharedPreferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

var dio = Dio();

class NetUtils {
  static SpUtil _spUtil;

  static Xml2Json transformer = Xml2Json();

  static Future getBaseUrl() async {
    _spUtil = await SpUtil.getInstance();
    var baseUrl = _spUtil.getString(SharedPreferencesKeys.teamCityServerUrl);
    return baseUrl;
  }

  static Future getAuthKey() async {
    _spUtil = await SpUtil.getInstance();
    var authKey = _spUtil.getString(SharedPreferencesKeys.basicKey);
    return authKey;
  }

  static Future get(String url, {Map<String, dynamic> params}) async {
    _spUtil = await SpUtil.getInstance();
    var baseUrl = await getBaseUrl();
    var authKey = await getAuthKey();

    var basicAuthHeader = 'Basic $authKey';

    Response response = new Response();
    try {
      response = await dio.get('$baseUrl/$url',
          queryParameters: params,
          options: Options(headers: {'Authorization': basicAuthHeader}));

      if (response.statusCode == 200) {
        transformer.parse(response.data);
        response.data = transformer.toGData();
      }
    } on DioError catch (e) {
      Fluttertoast.showToast(
        msg: '请求失败，确保自己连接葡萄城内网wifi,确保Teamcity服务可用。',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER
      );
      print('Dio error>>>>>>>>>>>>>>>>>>>>>>>>:');
      if (e.response != null) {
        response = e.response;
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
        print(e.message);
      }
    } finally {
      return response;
    }
  }
}
