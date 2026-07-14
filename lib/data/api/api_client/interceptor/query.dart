// import 'package:coamplifi_pro/config/app_config.dart';
// import 'package:coamplifi_pro/data/datasource/auth/auth_local_datasource_type.dart';
// import 'package:coamplifi_pro/data/datasource/auth/auth_remote_datasource_type.dart';
// import 'package:coamplifi_pro/data/dto/uaa_dto.dart';
// import 'package:coamplifi_pro/di.dart';
// import 'package:coamplifi_pro/domain/auth/failure.dart';
// import 'package:coamplifi_pro/domain/auth/user_auth_entity.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'package:coamplifi_pro/utils/timezone_provider.dart';

// class QueryInterceptor extends InterceptorsWrapper {
//   static const _authorization = 'Authorization';
//   static const _tzOffset = 'X-User-TZ-Offset';
//   static const _tz = 'X-User-TZ';

//   // final AuthLocalDatasourceType authLocalDatasource;
//   // final AuthRemoteDatasourceType authRemoteDatasource;
//   final String? identityBaseDomain;
//   final bool expectResponseJson;
//   final bool ignoreToken;
//   final Connectivity connectivity = Connectivity();
//   final bool ignoreConnection;

//   late String _authToken;
//   late String _refreshToken;

//   final authLocalDatasource = getIt<AuthLocalDatasourceType>();
//   final authRemoteDatasource = getIt<AuthRemoteDatasourceType>();

//   QueryInterceptor({
//     // required this.authLocalDatasource,
//     // required this.authRemoteDatasource,
//     required this.identityBaseDomain,
//     this.expectResponseJson = false,
//     this.ignoreConnection = false,
//     this.ignoreToken = false,
//   }) {
//     _init();
//   }

//   void _init() async {
//     final prefs = await SharedPreferences.getInstance();
//     String? accessToken = await authLocalDatasource.getAccessToken();
//     if (accessToken != null) {
//       _authToken = accessToken;
//       prefs.setString('jwt_token', accessToken);
//     }

//     String refreshToken = await authLocalDatasource.getRefreshToken() ?? '';
//     if (refreshToken != null) {
//       _refreshToken = refreshToken;
//       prefs.setString('refresh_token', refreshToken);
//     }
//   }

//   @override
//   Future onError(DioError err, ErrorInterceptorHandler handler) async {
//     final isInValidAuthenticationResponse =
//         await _isInValidAuthenticationResponse(err.response);

//     if (isInValidAuthenticationResponse) {
//       Either<Failure, UaaDTO> result =
//           await authRemoteDatasource.refreshUaa(_refreshToken);

//       return result.fold((failure) => Left(failure),
//           (uaaDTO) => _onRefreshUaaSuccess(err, uaaDTO));
//     } else {
//       return super.onError(err, handler);
//     }
//   }

//   Future<void> _onRefreshUaaSuccess(DioError err, UaaDTO dto) async {
//     UserAuthEntity? userAuthEntity = await authLocalDatasource.getUserAuth();

//     if (userAuthEntity != null) {
//       UserAuthEntity updatedUserAuthEntity = UserAuthEntity(
//           userAuthEntity.id,
//           userAuthEntity.name,
//           userAuthEntity.password,
//           dto.jwtAccessToken,
//           dto.jwtRefreshToken,
//           dto.currentTenantId,
//           dto.aggregateId,
//           dto.tenants);
//       await authLocalDatasource.saveUserAuth(updatedUserAuthEntity);
//       //await _retry(err.requestOptions);
//     }
//   }

//   // Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
//   //   final options = new Options(
//   //     method: requestOptions.method,
//   //     headers: requestOptions.headers,
//   //   );
//   //   return this.api.request<dynamic>(requestOptions.path,
//   //       data: requestOptions.data,
//   //       queryParameters: requestOptions.queryParameters,
//   //       options: options);
//   // }

//   @override
//   Future onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
//     final baseDomain = AppConfig.shared.baseDomain;
//     if (baseDomain.isNotEmpty) {
//       options.baseUrl = baseDomain;
//     }

//     final String? jwtTokenPrefs = await authLocalDatasource.getAccessToken();
//     options.headers[_authorization] = 'Bearer $jwtTokenPrefs';

//     // Use real IANA timezone identifier for DST correctness.
//     // This avoids offset->region ambiguity (e.g. -420 could be Mountain vs Pacific depending on DST).
//     options.headers[_tz] =
//         await TimezoneProvider.instance.getIanaTimezoneIdentifier();
//     return super.onRequest(options, handler);
//   }

//   @override
//   Future onResponse(
//       Response response, ResponseInterceptorHandler handler) async {
//     // final isInValidAuthenticationResponse = await _isInValidAuthenticationResponse(response);
//     // if (isInValidAuthenticationResponse) {
//     //   throw DioError(
//     //     requestOptions: response.requestOptions,
//     //     response: response,
//     //     type: DioErrorType.response,
//     //     error: 'Invalid token or current token is expired. Please try logging in again!',
//     //   );
//     // }
//     // if (!isResponseOkButNoContent(response) && expectResponseJson) {
//     //   throw DioError(
//     //     requestOptions: response.requestOptions,
//     //     response: response,
//     //     type: DioErrorType.response,
//     //     error: 'Response format is not a json response',
//     //   );
//     // }

//     return super.onResponse(response, handler);
//   }

//   Future<bool> _isInValidAuthenticationResponse(Response? response) async {
//     return response?.statusCode == 401;
//   }

//   // bool isResponseOkButNoContent(Response response) => response.statusCode == 204;

//   // bool? isResponseHeaderTypeJson(Map<String, List<String>> headerMap) {
//   //   return headerMap[_contentType]
//   //       ?.firstWhere((element) => element.contains(_applicationJson), orElse: () => '')
//   //       .contains(_applicationJson);
//   // }

//   // Future _validateConnection(RequestOptions options, RequestInterceptorHandler handler) async {
//   //   if (NavigationController.globalNavigatorKey.currentContext == null) {
//   //     return;
//   //   }
//   //   return showDialog(
//   //       context: NavigationController.globalNavigatorKey.currentContext!,
//   //       barrierDismissible: false,
//   //       builder: (context) {
//   //         return Container();
//   //       }).then((_) {
//   //         return onRequest(options, handler);
//   //   });
//   // }
// }
