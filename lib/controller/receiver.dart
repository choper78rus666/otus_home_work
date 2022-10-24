import 'package:dio/dio.dart';
import 'package:flutter_network_connectivity/flutter_network_connectivity.dart';

// класс для работы с API
class DioManager {
  dynamic dio;
  final FlutterNetworkConnectivity _flutterNetworkConnectivity =
      FlutterNetworkConnectivity(
    isContinousLookUp: true,
    lookUpDuration: const Duration(seconds: 3),
    lookUpUrl: 'foodapi.dzolotov.tech',
  );

  DioManager() {
    dio = Dio();
    dio.options.baseUrl = "http://foodapi.dzolotov.tech/";
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;
  }

  getHttp(String path, {String method = 'GET', dynamic data}) async {
    Response<dynamic>? response;

    // Проверка наличия интернета
    bool isNetworkConnectedOnCall =
        await _flutterNetworkConnectivity.isInternetConnectionAvailable();

    if (isNetworkConnectedOnCall) {
      response = await dio.request(
        path,
        data: data,
        options: Options(
          method: method,
          responseType: ResponseType.json,
        ),
      );
    }

    return response;
  }
}
