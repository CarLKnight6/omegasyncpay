


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';


// import '../presentation/auth/bloc/auth_bloc.dart';
// import '../presentation/auth/bloc/auth_state.dart';

// import 'named_routes.dart';
// import 'navigation_cubit.dart';
// import 'navigation_stack.dart';
// import 'page_config.dart';

// ///PopNavigatorRouterDelegateMixin wires android physical back button to its child Navigator
// class CSRouterDelegate extends RouterDelegate<PageConfig> with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfig> {

//   final NavigationCubit _cubit;

//   CSRouterDelegate(this._cubit);

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocListener(
//       listeners: [
//         //_listenForBootstrapping(),
//         _listenForAuth(),
//       ],
//       child: BlocConsumer<NavigationCubit, NavigationStack>(
//         builder: (context, stack) => Navigator(
//           pages: stack.pages,
//           key: navigatorKey,
//           onPopPage: (route, result) => _onPopPage.call(route, result),
//         ),
//         listener: (context, stack) {},
//       ),
//     );
//   }

//   ///here we handle back buttons
//   bool _onPopPage(Route<dynamic> route, dynamic result) {
//     final didPop = route.didPop(result);
//     if (!didPop) {
//       return false;
//     }
//     if (_cubit.canPop()) {
//       _cubit.pop();
//       return true;
//     } else {
//       return false;
//     }
//   }

//   ///you'll maybe want to remove those from here
//   // BlocListener _listenForBootstrapping() {
//   //   return BlocListener<BootstrappingBloc, BootstrappingState>(
//   //     listener: (context, state) {
//   //       // if (state is BootStrappingFailed) {
//   //       //   ///show some error page
//   //       // }
//   //     },
//   //   );
//   // }

//   BlocListener _listenForAuth() {
    
//     return BlocListener<AuthBloc, AuthState>(
//       listenWhen: (previous, current) {
//         return previous.runtimeType != current.runtimeType;
//       },
//       listener: (context, state) {
        
//         if (state is AuthenticatedAuthState) {
//           ///navigate to the page the user wants or for the home page
//           if (!_isCurrentRoute(NamedRoutes.home)) {
//             _cubit.clearAndPush(NamedRoutes.home);
//           }
//         }

//         if (state is UnauthenticatedAuthState) {
//           ///navigate to login/sign up/welcome page
//           if (!_isCurrentRoute(NamedRoutes.login)) {
//             _cubit.clearAndPush(NamedRoutes.login);
//           }
//         }

//         if (state is AuthenticationLoggedOut) {
//           ///navigate to login/sign up/welcome page
//           if (!_isCurrentRoute(NamedRoutes.login)) {
//             _cubit.clearAndPush(NamedRoutes.login);
//           }
//         }
//       },
//     );
//   }

//   bool _isCurrentRoute(String route) {
//     final stack = _cubit.state;
//     if (stack.length == 0) return false;
//     return stack.last.route == route;
//   }

//   @override
//   Future<void> setNewRoutePath(PageConfig configuration) async {
//     if (configuration.route != '/') _cubit.push(configuration.route, configuration.args);
//   }

//   ///called by router when it detects it may have changed because of a rebuild
//   ///necessary for backward and forward buttons to work properly
//   @override
//   PageConfig? get currentConfiguration => _cubit.state.last;

//   @override
//   final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
// }