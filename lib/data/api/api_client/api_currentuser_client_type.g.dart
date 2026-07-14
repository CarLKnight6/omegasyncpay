// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'api_currentuser_client_type.dart';

// // **************************************************************************
// // RetrofitGenerator
// // **************************************************************************

// // ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations

// class _ApiCurrentUserClientType implements ApiCurrentUserClientType {
//   _ApiCurrentUserClientType(this._dio, {this.baseUrl, this.errorLogger});

//   final Dio _dio;

//   String? baseUrl;

//   final ParseErrorLogger? errorLogger;

//   @override
//   Future<UserKey> getCurrentUser() async {
//     final _extra = <String, dynamic>{};
//     final queryParameters = <String, dynamic>{};
//     final _headers = <String, dynamic>{};
//     const Map<String, dynamic>? _data = null;
//     final _options = _setStreamType<UserKey>(
//       Options(method: 'GET', headers: _headers, extra: _extra)
//           .compose(
//             _dio.options,
//             '/cs/userservice/currentuser',
//             queryParameters: queryParameters,
//             data: _data,
//           )
//           .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
//     );
//     final _result = await _dio.fetch<Map<String, dynamic>>(_options);
//     late UserKey _value;
//     try {
//       _value = UserKey.fromJson(_result.data!);
//     } on Object catch (e, s) {
//       errorLogger?.logError(e, s, _options);
//       rethrow;
//     }
//     return _value;
//   }

//   @override
//   Future<dynamic> postAvatar(String shardKey, FormData formData) async {
//     final _extra = <String, dynamic>{};
//     final queryParameters = <String, dynamic>{};
//     final _headers = <String, dynamic>{};
//     final _data = formData;
//     final _options = _setStreamType<dynamic>(
//       Options(
//         method: 'POST',
//         headers: _headers,
//         extra: _extra,
//         contentType: 'multipart/form-data',
//       )
//           .compose(
//             _dio.options,
//             '/cg/fileservice/avatars/${shardKey}',
//             queryParameters: queryParameters,
//             data: _data,
//           )
//           .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
//     );
//     final _result = await _dio.fetch(_options);
//     final _value = _result.data;
//     return _value;
//   }

//   @override
//   Future<dynamic> getPositionsByUserId(String userId) async {
//     final _extra = <String, dynamic>{};
//     final queryParameters = <String, dynamic>{};
//     final _headers = <String, dynamic>{};
//     const Map<String, dynamic>? _data = null;
//     final _options = _setStreamType<dynamic>(
//       Options(method: 'GET', headers: _headers, extra: _extra)
//           .compose(
//             _dio.options,
//             '/cp/organizationservice/positionsByUserId/${userId}?includeReportTo',
//             queryParameters: queryParameters,
//             data: _data,
//           )
//           .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
//     );
//     final _result = await _dio.fetch(_options);
//     final _value = _result.data;
//     return _value;
//   }

//   @override
//   Future<dynamic> getCurrentPosition(List<String> formData) async {
//     final _extra = <String, dynamic>{};
//     final queryParameters = <String, dynamic>{};
//     final _headers = <String, dynamic>{r'Content-Type': 'application/json'};
//     _headers.removeWhere((k, v) => v == null);
//     final _data = formData;
//     final _options = _setStreamType<dynamic>(
//       Options(
//         method: 'POST',
//         headers: _headers,
//         extra: _extra,
//         contentType: 'application/json',
//       )
//           .compose(
//             _dio.options,
//             '/cp/systemservice/positionConfigsByIds',
//             queryParameters: queryParameters,
//             data: _data,
//           )
//           .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
//     );
//     final _result = await _dio.fetch(_options);
//     final _value = _result.data;
//     return _value;
//   }

//   @override
//   Future<dynamic> updatePassword(Map<String, dynamic> formData) async {
//     final _extra = <String, dynamic>{};
//     final queryParameters = <String, dynamic>{};
//     final _headers = <String, dynamic>{r'Content-Type': 'application/json'};
//     _headers.removeWhere((k, v) => v == null);
//     final _data = <String, dynamic>{};
//     _data.addAll(formData);
//     final _options = _setStreamType<dynamic>(
//       Options(
//         method: 'POST',
//         headers: _headers,
//         extra: _extra,
//         contentType: 'application/json',
//       )
//           .compose(
//             _dio.options,
//             '/uaa/changePasswordUaa',
//             queryParameters: queryParameters,
//             data: _data,
//           )
//           .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
//     );
//     final _result = await _dio.fetch(_options);
//     final _value = _result.data;
//     return _value;
//   }

//   RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
//     if (T != dynamic &&
//         !(requestOptions.responseType == ResponseType.bytes ||
//             requestOptions.responseType == ResponseType.stream)) {
//       if (T == String) {
//         requestOptions.responseType = ResponseType.plain;
//       } else {
//         requestOptions.responseType = ResponseType.json;
//       }
//     }
//     return requestOptions;
//   }

//   String _combineBaseUrls(String dioBaseUrl, String? baseUrl) {
//     if (baseUrl == null || baseUrl.trim().isEmpty) {
//       return dioBaseUrl;
//     }

//     final url = Uri.parse(baseUrl);

//     if (url.isAbsolute) {
//       return url.toString();
//     }

//     return Uri.parse(dioBaseUrl).resolveUri(url).toString();
//   }
// }
