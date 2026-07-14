// import 'package:retrofit/retrofit.dart';
// import 'package:dio/dio.dart' hide Headers;

// part 'api_client_type.g.dart';

// @RestApi()
// abstract class APIClientType {
//   factory APIClientType(Dio dio, {String baseUrl}) = _APIClientType;

//   @POST('/uaa/oauth/token')
//   @FormUrlEncoded()
//   @Headers(<String, dynamic>{
//     'Authorization': 'Basic asdasdasdkl;k',
//     'Content-Type': 'application/x-www-form-urlencoded',
//     'G-Recaptcha-Token': 'appname',
//   })
//   Future<String> fetchJwtToken(
//     @Field('username') String username,
//     @Field('password') String password, {
//     @Field('grant_type') String type = 'password',
//   });
// }
