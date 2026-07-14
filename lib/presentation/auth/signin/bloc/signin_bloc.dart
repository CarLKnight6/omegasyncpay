// import 'dart:convert';

// import 'package:coamplifi_pro/domain/auth/auth_usecase_type.dart';
// import 'package:coamplifi_pro/domain/currentuser/currentuser_usecase_type.dart';
// import 'package:coamplifi_pro/presentation/auth/bloc/auth_bloc.dart';
// import 'package:coamplifi_pro/presentation/auth/bloc/auth_event.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'signin_event.dart';
// import 'signin_state.dart';

// class SigninBloc extends Bloc<SigninEvent, SigninState> {
//   final AuthBloc authBloc;
//   final AuthUsecaseType authUsecase;
//   final CurrentUserUsecaseType currentUserUsecase;

//   SigninBloc(
//       {required this.authBloc,
//       required this.authUsecase,
//       required this.currentUserUsecase})
//       : super(SigninInitial()) {
//     on<SigninEvent>(mapEventToState);
//   }
//   String encodePlusCharacter(String input) {
//     return input.replaceAll('+', '%2B');
//   }

//   void mapEventToState(SigninEvent event, Emitter<SigninState> emit) async {
//     if (event is SigninButtonPressed) {
//       emit(LoadingSigninState());

//       var connectivityResult = await (Connectivity().checkConnectivity());

//       if (connectivityResult == ConnectivityResult.none) {
//         print('offline');
//         emit(const FailureSigninState('Please check your network connection'));
//       }

//       //final request = LoginRequest(event.email, event.password);
//       print('login details');
//       print(event.recaptchaToken);
//       print(event.email);
//       print(event.password);
//       print(encodePlusCharacter(event.password));
//       try {
//         final encodedPassword = encodePlusCharacter(event.password);
//         final response = await authUsecase.login(
//             event.email, encodedPassword, event.recaptchaToken);

//         // final response = await authUsecase.login(event.email, event.password);
//         response.fold(
//           (failure) => emit(FailureSigninState(failure.message)),
//           //(userAuthEntity) =>  _authBloc.add(LoggedIn(userAuthEntity.jwt, userAuthEntity.email))
//           (userAuthEntity) async {
//             final prefs = await SharedPreferences.getInstance();
//             prefs.setString('aggregateId', userAuthEntity.aggregateId!);
//             prefs.setString('currentTenantId', userAuthEntity.currentTenantId!);

//             authBloc
//                 .add(LoggedInAuthEvent(token: 'userAuthEntity.jwtAccessToken'));
//             final current = await currentUserUsecase.getVisibilityData();
//             current.fold((l) {}, (r) {
//               List<dynamic> emails = [];
//               r.assistantOf?.forEach((element) {
//                 emails.add({
//                   "email": element.email,
//                   "shardKey": element.shardKey,
//                   "firstName": element.firstName,
//                   "lastName": element.lastName
//                 });
//               });

//               prefs.setString('assistantOf', jsonEncode(emails).toString());
//             });
//           },
//           // Right(UserAuthEntity(
//           //   uaaDTO.id,
//           //   uaaDTO.name,
//           //   uaaDTO.password,
//           //   uaaDTO.jwtAccessToken,
//           //   uaaDTO.jwtRefreshoken
//           // )),
//         );
//         // if(response.isLeft()) {
//         //   emit (FailureSigninState('Invalid email or password. Please try again.'));
//         // }
//       } catch (error) {
//         emit(FailureSigninState(error.toString()));
//       }
//       // try {

//       //   final response = await authUsecase.login(event.email, event.password);

//       //   //authBloc.add(LoggedIn(response.jwt, response.email));

//       // } on UnauthorizedException {

//       //   emit (FailureSigninState('Invalid email or password. Please try again.'));

//       // } catch (error) {
//       //   emit (FailureSigninState(error.toString()));
//       // }
//     }
//   }

//   // @override
//   // Stream<SignInState> mapEventToState(SignInEvent event) async* {

//   //   if (event is SignInButtonPressed) {

//   //     yield SignInLoading();

//   //     final request = LoginRequest(event.email, event.password);

//   //     try {

//   //       final response = await UserService().login(request);

//   //       authenticationBloc.add(LoggedIn(response.jwt, response.email));

//   //     } on UnauthorizedException {

//   //       yield SignInFailure(error: 'Invalid email or password. Please try again.');

//   //     } catch (error) {

//   //       yield SignInFailure(error: error.toString());

//   //     }
//   //   }
//   // }
// }
