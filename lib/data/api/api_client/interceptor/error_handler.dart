// import 'package:dio/dio.dart';
// import 'package:graphql/client.dart';

// class ErrorInterceptor extends Interceptor {
//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) {
//     switch (err.type) {
//       case DioExceptionType.connectionTimeout:
//       case DioExceptionType.sendTimeout:
//       // case DioExceptionType.receiveTimeout:
//       //   throw NetworkException('Connection timeout', 'TIMEOUT');

//       case DioExceptionType.badResponse:
//         final statusCode = err.response?.statusCode;
//         final data = err.response?.data;

//         switch (statusCode) {
//           case 400:
//             throw Exception('400 Error Message $data');
//           // throw ValidationException(
//           //   data['message'] ?? 'Validation error',
//           //   data['errors'],
//           //   'VALIDATION_ERROR'
//           // );
//           // case 401:
//           //   throw UnauthorizedException('Unauthorized', 'UNAUTHORIZED');
//           // case 500:
//           //   throw ServerException('Server error', 'SERVER_ERROR');
//           default:
//             throw Exception('Default Bad Response Message $data');
//         }

//       // case DioExceptionType.cancel:
//       //   throw AppException('Request cancelled', 'CANCELLED');

//       default:
//         throw Exception('default ERror Message');
//       // throw NetworkException('Network error', 'NETWORK_ERROR');
//     }
//   }
// }
