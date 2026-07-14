// import 'package:coamplifi_pro/data/dto/organization_service_current_dto.dart';
// import 'package:coamplifi_pro/domain/auth/failure.dart';
// import 'package:coamplifi_pro/domain/auth/user_key.dart';
// import 'package:coamplifi_pro/model/position.dart';
// import 'package:coamplifi_pro/model/position_dto.dart';

// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import '../../data/datasource/currentuser/currentuser_remote_datasource_type.dart';
// import 'currentuser_repository_type.dart';
// import 'currentuser_usecase_type.dart';

// class CurrentUserUsecase implements CurrentUserUsecaseType {
//   final CurrentUserRepositoryType currentuserRepository;

//   final CurrentUserRemoteDatasourceType currentuserRemoteDatasource;

//   CurrentUserUsecase(
//       {required this.currentuserRemoteDatasource,
//       required this.currentuserRepository});

//   @override
//   Future<Either<Failure, UserKey>> loadCurrentUserData() async {
//     final result = await currentuserRepository.fetchCurrentUser();
//     return result.fold((l) {
//       return Left(l);
//     }, (r) {
//       return Right(r);
//     });
//   }

//   @override
//   Future<dynamic> updateAvatar(String shardKey, FormData payload) async {
//     final result = await currentuserRepository.postAvatar(shardKey, payload);

//     return result.fold((l) {
//       return Left(l);
//     }, (r) {
//       return Right(r);
//     });
//   }

//   @override
//   Future<Either<Failure, Position>> getPosition(List<String> data) async {
//     final result = await currentuserRepository.fetchCurrentPosition(data);

//     return result.fold((l) {
//       return Left(l);
//     }, (r) {
//       return Right(r);
//     });
//   }

//   @override
//   Future updatePassword(Map<String, dynamic> payload) async {
//     final result = await currentuserRepository.updatePassword(payload);

//     return result.fold((l) {
//       return Left(l);
//     }, (r) {
//       return Right(r);
//     });
//   }

//   @override
//   Future<Either<Failure, PositionDTO>> getPositionByUserId(
//       String userId) async {
//     final result =
//         await currentuserRepository.fetchCurrentPositionByUserId(userId);

//     return result.fold((l) {
//       return Left(l);
//     }, (r) {
//       return Right(r);
//     });
//   }

//   @override
//   Future<Either<Failure, OrganizationServiceCurrentDTO>>
//       getVisibilityData() async {
//     final result = await currentuserRepository.getVisibilityData();
//     return result.fold((l) {
//       return Left(l);
//     }, (r) {
//       return Right(r);
//     });
//   }
// }
// //TODO:modified
