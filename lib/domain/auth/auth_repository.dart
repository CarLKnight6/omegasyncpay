// import 'package:coamplifi_pro/data/api/api_client/response/error_response.dart';
// import 'package:coamplifi_pro/data/datasource/auth/auth_local_datasource_type.dart';
// import 'package:coamplifi_pro/data/datasource/auth/auth_remote_datasource_type.dart';
// import 'package:coamplifi_pro/domain/auth/failure.dart';
// import 'package:dartz/dartz.dart';

// import 'auth_repository_type.dart';
// import 'user_auth_entity.dart';

// class AuthRepository implements AuthRepositoryType {
//   final AuthLocalDatasourceType authLocalDatasource;
//   final AuthRemoteDatasourceType authRemoteDatasource;

//   AuthRepository(
//       {required this.authLocalDatasource, required this.authRemoteDatasource});

//   @override
//   Future<Either<ErrorResponse, UserAuthEntity>> getUserAuth() async {
//     try {
//       UserAuthEntity? response = await authLocalDatasource.getUserAuth();

//       if (response != null) {
//         return Right(response);
//       } else {
//         return const Left(NoDataErrorResponse());
//       }
//     } catch (e) {
//       return Left(ErrorResponse(e.toString()));
//     }
//   }

//   @override
//   Future<void> saveUserAuth(UserAuthEntity userAuthentication) async {
//     print('saveAuth');
//     await authLocalDatasource.saveUserAuth(userAuthentication);
//   }

//   @override
//   Future<void> deleteUserAuth() async {
//     await authLocalDatasource.deleteUserAuth();
//   }

//   @override
//   Future<Either<ErrorResponse, dynamic>> forgotPassword() async {
//     try {
//       UserAuthEntity? response = await authLocalDatasource.getUserAuth();

//       if (response != null) {
//         return Right(response);
//       } else {
//         return const Left(NoDataErrorResponse());
//       }
//     } catch (e) {
//       return Left(ErrorResponse(e.toString()));
//     }
//   }
// }
