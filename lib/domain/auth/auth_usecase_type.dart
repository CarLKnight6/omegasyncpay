// import 'package:coamplifi_pro/domain/auth/tenant_info.dart';
// import 'package:coamplifi_pro/domain/auth/user_auth_entity.dart';
// import 'package:coamplifi_pro/domain/auth/failure.dart';

// import 'package:dartz/dartz.dart';

// import 'current_user_info.dart';

// abstract class AuthUsecaseType {
//   Future<Either<Failure, bool>> hasJwtToken();

//   Future<Either<Failure, CurrentUserInfo>> getCurrentUserInfo();

//   Future<Either<Failure, CurrentUserInfo>> sharedPrefsUser();

//   Future<Either<Failure, List<TenantInfo>>> fetchTenants();

//   Future<void> tenantSwitch(String tenantId);

//   Future<Either<Failure, List<dynamic>?>> getAuthorities();

//   Future<Either<Failure, UserAuthEntity>> login(
//     String name,
//     String password,
//     String recaptchaToken,
//   );

//   Future<Either<Failure, UserAuthEntity>> assistant(
//       String name, String password);

//   Future<void> endAssistant();

//   Future<void> logout();
// }
