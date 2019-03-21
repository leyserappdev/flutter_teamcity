import 'package:dio/dio.dart';

Future<Response> validTeamcityUserPassword(
    {String basicAuthKey, String serverUrl}) async {
  var dio = Dio();
  var basicAuthHeader = 'Basic $basicAuthKey';

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
