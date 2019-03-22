import 'package:dio/dio.dart';
import 'package:xml2json/xml2json.dart';
import './sharedPreferences.dart';

var dio = Dio();

class NetUtils {
  static SpUtil _spUtil;

  static Xml2Json transformer = Xml2Json();

  static Future get(String url, {Map<String, dynamic> params}) async {
    _spUtil = await SpUtil.getInstance();
    var baseUrl = _spUtil.getString(SharedPreferencesKeys.teamCityServerUrl);
    var authKey = _spUtil.getString(SharedPreferencesKeys.basicKey);

    var basicAuthHeader = 'Basic $authKey';

    Response response;
    try {
      response = await dio.get('$baseUrl/$url',
          queryParameters: params,
          options: Options(headers: {'Authorization': basicAuthHeader}));

      if (response.statusCode == 200) {
        transformer.parse(response.data);
        response.data = transformer.toGData();
      }
    } on DioError catch (e) {
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
