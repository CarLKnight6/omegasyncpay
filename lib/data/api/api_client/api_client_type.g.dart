// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'api_client_type.dart';

// // **************************************************************************
// // RetrofitGenerator
// // **************************************************************************

// // ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations

// class _APIClientType implements APIClientType {
//   _APIClientType(this._dio, {this.baseUrl, this.errorLogger});

//   final Dio _dio;

//   String? baseUrl;

//   final ParseErrorLogger? errorLogger;

//   @override
//   Future<String> fetchJwtToken(
//     String username,
//     String password, {
//     String type = 'password',
//   }) async {
//     final _extra = <String, dynamic>{};
//     final queryParameters = <String, dynamic>{};
//     final _headers = <String, dynamic>{
//       r'Authorization':
//           'Basic bXktdHJ1c3RlZC1jbGllbnQtd2l0aC1zZWNyZXQ6c29tZXNlY3JldA==',
//       r'Content-Type': 'application/x-www-form-urlencoded',
//       r'G-Recaptcha-Token': 'CURAESOFT',
//     };
//     _headers.removeWhere((k, v) => v == null);
//     final _data = {
//       'username': username,
//       'password': password,
//       'grant_type': type,
//     };
//     final _options = _setStreamType<String>(
//       Options(
//         method: 'POST',
//         headers: _headers,
//         extra: _extra,
//         contentType: 'application/x-www-form-urlencoded',
//       )
//           .compose(
//             _dio.options,
//             '/uaa/oauth/token',
//             queryParameters: queryParameters,
//             data: _data,
//           )
//           .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
//     );
//     final _result = await _dio.fetch<String>(_options);
//     late String _value;
//     try {
//       _value = _result.data!;
//     } on Object catch (e, s) {
//       errorLogger?.logError(e, s, _options);
//       rethrow;
//     }
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
