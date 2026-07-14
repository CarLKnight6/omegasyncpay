// import 'dart:io';

// import 'package:coamplifi_pro/data/api/api_client/interceptor/curl_log.dart';

// import 'package:dio/dio.dart';
// import 'package:dio/io.dart';

// import 'api_client_type.dart';

// abstract class APIClient {
//   static APIClientType apiClient(
//       {required String baseDomain,
//       String? identityBaseDomain,
//       bool disableRequestBodyLogging = false,
//       bool ignoreToken = false,
//       bool ignoreConnection = false,
//       required String baseUrl}) {
//     final dio = Dio(BaseOptions(
//       baseUrl: baseDomain,
//       receiveTimeout: const Duration(seconds: 15), // 15 seconds
//       connectTimeout: const Duration(seconds: 15),
//       sendTimeout: const Duration(seconds: 15),
//     ));

//     (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
//         (client) {
//       client.badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//     };

//     dio.interceptors
//         .add(CurlLogInterceptor(disableRequestBody: disableRequestBodyLogging));

//     // dio.interceptors.add(QueryInterceptor(
//     //     identityBaseDomain: identityBaseDomain,
//     //     ignoreConnection: ignoreConnection,
//     //     ignoreToken: ignoreToken));

//     return APIClientType(dio, baseUrl: baseDomain);
//   }
// }
