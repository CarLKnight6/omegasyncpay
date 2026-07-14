// import 'package:coamplifi_pro/data/api/api_client/interceptor/curl_log.dart';
// import 'package:coamplifi_pro/data/api/api_client/interceptor/query.dart';
// import 'package:coamplifi_pro/data/datasource/auth/auth_local_datasource_type.dart';
// import 'package:coamplifi_pro/data/datasource/auth/auth_remote_datasource_type.dart';

// import 'package:dio/dio.dart';
// import 'package:dio/io.dart';
// import 'dart:io';

// import 'api_currentuser_client_type.dart';

// class APICurrentUserClient {
//   static ApiCurrentUserClientType apiCurrentUserClient(
//       {required String baseDomain,
//       required String authToken,
//       String? identityBaseDomain,
//       bool disableRequestBodyLogging = false,
//       bool ignoreToken = false,
//       bool ignoreConnection = false,
//       required AuthLocalDatasourceType authLocalDatasource,
//       required AuthRemoteDatasourceType authRemoteDatasource}) {
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

//     /// NOTE:
//     /// Uncomment below if you need to see console statements about your api
//     dio.interceptors
//         .add(CurlLogInterceptor(disableRequestBody: disableRequestBodyLogging));

//     dio.interceptors.add(QueryInterceptor(
//         identityBaseDomain: identityBaseDomain,
//         ignoreConnection: ignoreConnection,
//         ignoreToken: ignoreToken));

//     return ApiCurrentUserClientType(dio, baseUrl: baseDomain);
//   }

//   //TODO:modified
// }
