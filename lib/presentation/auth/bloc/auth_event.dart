// import 'package:equatable/equatable.dart';

// abstract class AuthEvent extends Equatable {
//   const AuthEvent([List props = const []]);

//   @override
//   List<Object> get props => [];

//   //const AuthenticationEvent([List props = const []]) : super(props);
// }

// class AppStartedAuthEvent extends AuthEvent {
//   @override
//   String toString() => 'AppStarted';
// }

// class LoggedInAuthEvent extends AuthEvent {
//   final String token;

//   LoggedInAuthEvent({required this.token}) : super([token]);

//   @override
//   String toString() => 'LoggedIn { token: $token }';
// }

// class LoggedOutAuthEvent extends AuthEvent {
//   @override
//   String toString() => 'LoggedOut';
// }

// class UserDeleted extends AuthEvent {
//   @override
//   String toString() => 'UserDeleted';
// }

// class AssitantMode extends AuthEvent {
//   final String userEmail;
//   final String assistEmail;
//   final String password;

//   AssitantMode(
//       {required this.userEmail,
//       required this.assistEmail,
//       required this.password})
//       : super([userEmail, assistEmail, password]);

//   @override
//   String toString() => 'AssitantMode';
// }

// class EndAssitantMode extends AuthEvent {
//   @override
//   String toString() => 'EndAssitantMode';
// }
