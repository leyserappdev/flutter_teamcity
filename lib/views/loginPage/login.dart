import 'package:dio/dio.dart';
import 'dart:convert';

Future<Response> validTeamcityUserPassword(
    {String userName, String password, String serverUrl}) async {
  var dio = Dio();
  var basicAuthHeader =
      'Basic ${base64.encode(utf8.encode('$userName:$password'))}';

  Response response;
  try {
    response = await dio.get('$serverUrl/httpAuth/app/rest/projects',
        options: Options(headers: {'Authorization': basicAuthHeader}));
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
