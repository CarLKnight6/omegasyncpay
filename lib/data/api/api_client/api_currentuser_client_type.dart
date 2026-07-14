// import 'package:coamplifi_pro/model/position.dart';
// import 'package:retrofit/retrofit.dart';
// import 'package:dio/dio.dart' hide Headers;
// import '../../../domain/auth/user_key.dart';
// part 'api_currentuser_client_type.g.dart';

// @RestApi()
// abstract class ApiCurrentUserClientType {
//   factory ApiCurrentUserClientType(Dio dio, {String baseUrl}) =
//       _ApiCurrentUserClientType;

//   @GET('/cs/userservice/currentuser')
//   Future<UserKey> getCurrentUser();

//   @POST('/cg/fileservice/avatars/{shardKey}')
//   @MultiPart()
//   Future<dynamic> postAvatar(
//     @Path("shardKey") String shardKey,
//     @Body() FormData formData,
//   );

// //coamplifi.curaesoft.com/cp/organizationservice/positionsByUserId/CSU000040154?includeReportTo
//   @GET('/cp/organizationservice/positionsByUserId/{userId}?includeReportTo')
//   Future<dynamic> getPositionsByUserId(
//     @Path("userId") String userId,
//   );

//   @POST('/cp/systemservice/positionConfigsByIds')
//   @Headers(<String, dynamic>{
//     'Content-Type': 'application/json',
//   })
//   Future<dynamic> getCurrentPosition(
//     @Body() List<String> formData,
//   );

//   @POST('/uaa/changePasswordUaa')
//   @Headers(<String, dynamic>{
//     'Content-Type': 'application/json',
//   })
//   Future<dynamic> updatePassword(
//     @Body() Map<String, dynamic> formData,
//   );
// } 




// //TODO:modified