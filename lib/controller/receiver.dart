import 'package:dio/dio.dart';
import 'package:flutter_network_connectivity/flutter_network_connectivity.dart';

// класс для работы с API
class DioManager {
  dynamic dio;
  FlutterNetworkConnectivity flutterNetworkConnectivity =
      FlutterNetworkConnectivity(
    isContinousLookUp: true,
    // optional, false if you cont want continous lookup
    lookUpDuration: const Duration(seconds: 3),
    // optional, to override default lookup duration
    lookUpUrl:
        'foodapi.dzolotov.tech', // optional, to override default lookup url
  );

  DioManager() {
    dio = Dio();
    dio.options.baseUrl = "http://foodapi.dzolotov.tech/";
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;
  }

  getHttp(String path, {String method = 'GET'}) async {
    Response<dynamic>? response;

    // Проверка наличия интернета
    bool isNetworkConnectedOnCall =
        await flutterNetworkConnectivity.isInternetConnectionAvailable();

    if (isNetworkConnectedOnCall) {
      response = await dio.request(
        path,
        options: Options(
          method: method,
          responseType: ResponseType.json,
        ),
      );
    }

    return response;
  }
}
