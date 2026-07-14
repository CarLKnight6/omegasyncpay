// //import 'dart:async';

// import 'dart:convert';

// import 'package:coamplifi_pro/data/datasource/auth/auth_local_datasource_type.dart';
// import 'package:coamplifi_pro/data/datasource/auth/auth_remote_datasource_type.dart';
// import 'package:coamplifi_pro/domain/auth/auth_usecase_type.dart';
// import 'package:coamplifi_pro/domain/auth/tenant_info.dart';
// import 'package:coamplifi_pro/domain/auth/user_auth_entity.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'auth_event.dart';
// import 'auth_state.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final AuthUsecaseType authUsecase;
//   final AuthLocalDatasourceType authLocalDatasource;
//   final AuthRemoteDatasourceType authRemoteDatasource;

//   AuthBloc(
//       {required this.authUsecase,
//       required this.authLocalDatasource,
//       required this.authRemoteDatasource})
//       : super(AuthenticationUninitialized()) {
//     on<AppStartedAuthEvent>((event, emit) => _onAppStartedAuthEvent(emit));

//     on<LoggedInAuthEvent>((event, emit) => _onLoggedInAuthEvent(emit));

//     on<LoggedOutAuthEvent>((event, emit) => _onLoggedOutAuthEvent(emit));

//     on<AssitantMode>((event, emit) => _onAssistantMode(
//         emit, event.userEmail, event.assistEmail, event.password));

//     on<EndAssitantMode>((event, emit) => _endAssistantMode(emit));
//   }

//   void mapEventToState(AuthEvent event, Emitter<AuthState> emit) async {
//     //await future.whenComplete(() => emit(...));

//     //print(event.toString());

//     if (event is AppStartedAuthEvent) {
//       await _onAppStartedAuthEvent(emit);

//       //await whenComplete(
//       //_appStarted(emit);
//       //)
//     } else if (event is LoggedInAuthEvent) {
//       await _onLoggedInAuthEvent(emit);
//       //_loggedIn(event, emit);
//     } else if (event is LoggedOutAuthEvent) {
//       _loggedOut(event, emit);
//     }
//     // else if (event is OnboardingStepCompleted) {
//     //   yield* _initStartup();
//     // }
//     else if (event is UserDeleted) {
//       _userDeleted(emit);
//     } else if (event is AssitantMode) {
//       await _onAssistantMode(
//           emit, event.userEmail, event.assistEmail, event.password);
//     } else if (event is EndAssitantMode) {
//       await _endAssistantMode(emit);
//     }
//   }

//   Future<void> _onAppStartedAuthEvent(Emitter<AuthState> emit) async {
//     try {
//       final hasJwtToken = await authUsecase.hasJwtToken();
//       final refreshToken = await authLocalDatasource.getRefreshToken() ?? '';
//       final refreshResult = await authRemoteDatasource.refreshUaa(refreshToken);
//       final userAuthEntity = await authLocalDatasource.getUserAuth();

//       await hasJwtToken.fold(
//         (l) async {
//           emit(UnauthenticatedAuthState());
//         },
//         (r) async {
//           await refreshResult.fold(
//             (failure) async {
//               await authUsecase.logout();
//               emit(UnauthenticatedAuthState(message: failure.message));
//             },
//             (dto) {
//               if (userAuthEntity != null) {
//                 UserAuthEntity updatedUserAuthEntity = UserAuthEntity(
//                     userAuthEntity.id,
//                     userAuthEntity.name,
//                     userAuthEntity.password,
//                     dto.jwtAccessToken,
//                     dto.jwtRefreshToken,
//                     dto.currentTenantId,
//                     dto.aggregateId,
//                     dto.tenants);
//                 _saveUserAuth(updatedUserAuthEntity);
//               }
//               emit(AuthenticatedAuthState());
//             },
//           );
//         },
//       );
//     } catch (e) {
//       emit(UnauthenticatedAuthState());
//     }
//   }

//   Future<void> _saveUserAuth(UserAuthEntity userAuthEntity) async {
//     await authLocalDatasource.saveUserAuth(userAuthEntity);
//   }

//   Future<void> _onLoggedInAuthEvent(Emitter<AuthState> emit) async {
//     final prefs = await SharedPreferences.getInstance();
//     dynamic value = await authUsecase.getCurrentUserInfo();
//     String fName = value.value.userKey.firstName;
//     String lName = value.value.userKey.lastName;
//     String name = fName[0].toUpperCase() +
//         fName.substring(1) +
//         ' ' +
//         lName[0].toUpperCase() +
//         lName.substring(1);
//     prefs.setString('displayName', name);

//     emit(AuthenticatedAuthState());
//   }

//   Future<void> _onLoggedOutAuthEvent(Emitter<AuthState> emit) async {
//     await authUsecase.logout();
//     emit(AuthenticationLoggedOut());
//   }

//   Future<void> _onAssistantMode(Emitter<AuthState> emit, String userEmail,
//       String assistEmail, String password) async {
//     final result =
//         await authUsecase.assistant('$assistEmail:$userEmail', password);
//     result.fold((l) => null, (r) => emit(AuthenticatedAssistantMode()));
//   }

//   Future<void> _endAssistantMode(Emitter<AuthState> emit) async {
//     await authUsecase.endAssistant();
//     emit(AuthenticatedAuthState());
//   }

//   Future<List<TenantInfo>> buildfetchTenants() async {
//     return authUsecase.fetchTenants().then((value) {
//       return value.fold((l) => [], (r) {
//         return r;
//       });
//     });
//   }

//   //emit(AuthenticationLoggingOut());

//   //await userRepository.deleteToken();

//   // void  _appStarted(Emitter<AuthState> emit) async {

//   //   _cleanIfFirstUseAfterUninstall();

//   //   _initStartup(emit);
//   // }

//   void _initStartup(Emitter<AuthState> emit) async {
//     final hasJwtToken = await authUsecase.hasJwtToken();

//     hasJwtToken.fold((failur) => emit(UnauthenticatedAuthState()),
//         (right) => emit(AuthenticatedAuthState()));
//   }

//   void _loggedIn(LoggedInAuthEvent event, Emitter<AuthState> emit) async {
//     //emit(LoadingAuthState());

//     // await userRepository.persistEmailAndToken(event.email, event.token);

//     _initStartup(emit);
//   }

//   void _loggedOut(LoggedOutAuthEvent event, Emitter<AuthState> emit) async {
//     emit(AuthenticationLoggingOut());

//     //await userRepository.deleteToken();
//   }

//   void _userDeleted(Emitter<AuthState> emit) async {
//     //await userRepository.deleteAll();

//     emit(UnauthenticatedAuthState());
//   }

//   void _cleanIfFirstUseAfterUninstall() async {
//     // final prefs = await SharedPreferences.getInstance();

//     // if (prefs.getBool('first_run') ?? true) {
//     //   await userRepository.deleteAll();
//     //   await prefs.setBool('first_run', false);
//     // }
//   }
// }
