// import 'package:coamplifi_pro/components/custom_button.dart';
// import 'package:coamplifi_pro/components/error_snackbar.dart';
// import 'package:coamplifi_pro/components/text_form_field.dart';
// import 'package:coamplifi_pro/components/validating_text_form_field.dart';
// import 'package:coamplifi_pro/config/app_config.dart';
// import 'package:coamplifi_pro/di.dart';
// import 'package:coamplifi_pro/domain/auth/auth_usecase_type.dart';
// import 'package:coamplifi_pro/domain/currentuser/currentuser_usecase_type.dart';
// // import 'package:coamplifi_pro/model/visit_models/user_info_model.dart';
// import 'package:coamplifi_pro/presentation/auth/bloc/auth_bloc.dart';
// import 'package:coamplifi_pro/presentation/auth/bloc/auth_state.dart';
// import 'package:coamplifi_pro/presentation/auth/signin/bloc/signin_event.dart';
// import 'package:coamplifi_pro/presentation/theme/bloc/theme_bloc.dart';
// import 'package:coamplifi_pro/presentation/widgets/standard_text_button.dart';
// import 'package:coamplifi_pro/presentation/widgets/text_widget.dart';
// import 'package:coamplifi_pro/router/named_routes.dart';
// import 'package:coamplifi_pro/router/navigation_cubit.dart';
// import 'package:coamplifi_pro/utils/constants.dart';

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'bloc/signin_bloc.dart';
// import 'bloc/signin_state.dart';

// class SigninScreen extends StatefulWidget {
//   const SigninScreen({Key? key}) : super(key: key);

//   @override
//   State<SigninScreen> createState() => _SigninScreenState();
// }

// class _SigninScreenState extends State<SigninScreen> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AuthBloc, AuthState>(
//       listener: (context, state) {
//         if (state is UnauthenticatedAuthState && state.message != null) {
//           ScaffoldMessenger.of(context).showSnackBar(
//               ErrorSnackbar.buildErrorSnackbar(
//                   context, state.message ?? 'error'));
//         }
//       },
//       child: Scaffold(
//         backgroundColor:
//             BlocProvider.of<ThemeBloc>(context).state.themeData.cardTheme.color,
//         body: LayoutBuilder(
//           builder: (BuildContext context, BoxConstraints viewportConstraints) {
//             return SingleChildScrollView(
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(
//                   minHeight: viewportConstraints.maxHeight,
//                 ),
//                 child: IntrinsicHeight(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 38),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Expanded(
//                           child: SizedBox(
//                             height: 80,
//                           ),
//                         ),
//                         Text(
//                           'sign_in'.tr(),
//                           style: TextStyle(
//                             fontSize: 28,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 30,
//                         ),
//                         WidgetSignin(),
//                         Center(
//                           child: StandardTextButton(
//                             onPressed: () {
//                               context.read<NavigationCubit>().push(
//                                   NamedRoutes.forgotPassword, {'reset': false});
//                             },
//                             label: Text(
//                               'forgot_your_password'.tr(),
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .labelLarge!
//                                   .copyWith(fontSize: 12),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         Expanded(
//                           child: SizedBox(
//                             height: 20,
//                           ),
//                         ),

//                         // ElevatedButton(
//                         //     onPressed: () {
//                         //       showModalBottomSheet(
//                         //         context: context,
//                         //         isScrollControlled: true,
//                         //         builder: (context) {
//                         //           return DraggableScrollableSheet(
//                         //             initialChildSize:
//                         //                 0.5, // Initial height as a fraction of the screen
//                         //             minChildSize: 0.25, // Minimum height
//                         //             maxChildSize: 0.9, // Maximum height
//                         //             expand:
//                         //                 false, // If true, the sheet expands to fill available space
//                         //             builder: (BuildContext context,
//                         //                 ScrollController scrollController) {
//                         //               return Container(
//                         //                 decoration: const BoxDecoration(
//                         //                   color: Colors.white,
//                         //                   borderRadius: BorderRadius.vertical(
//                         //                       top: Radius.circular(20)),
//                         //                 ),
//                         //                 child: ListView.builder(
//                         //                   controller:
//                         //                       scrollController, // Crucial for synchronized scrolling
//                         //                   itemCount: 50,
//                         //                   itemBuilder:
//                         //                       (BuildContext context, int index) {
//                         //                     return ElevatedButton(
//                         //                         onPressed: () {
//                         //                           showModalBottomSheet(
//                         //                             context: context,
//                         //                             isScrollControlled: true,
//                         //                             builder: (context) {
//                         //                               return DraggableScrollableSheet(
//                         //                                 initialChildSize:
//                         //                                     0.5, // Initial height as a fraction of the screen
//                         //                                 minChildSize:
//                         //                                     0.25, // Minimum height
//                         //                                 maxChildSize:
//                         //                                     0.9, // Maximum height
//                         //                                 expand:
//                         //                                     false, // If true, the sheet expands to fill available space
//                         //                                 builder: (BuildContext
//                         //                                         context,
//                         //                                     ScrollController
//                         //                                         scrollController) {
//                         //                                   return Container(
//                         //                                     decoration:
//                         //                                         const BoxDecoration(
//                         //                                       color: Colors.white,
//                         //                                       borderRadius:
//                         //                                           BorderRadius.vertical(
//                         //                                               top: Radius
//                         //                                                   .circular(
//                         //                                                       20)),
//                         //                                     ),
//                         //                                     child:
//                         //                                         ListView.builder(
//                         //                                       controller:
//                         //                                           scrollController, // Crucial for synchronized scrolling
//                         //                                       itemCount: 50,
//                         //                                       itemBuilder:
//                         //                                           (BuildContext
//                         //                                                   context,
//                         //                                               int index) {
//                         //                                         return ElevatedButton(
//                         //                                             onPressed:
//                         //                                                 () {},
//                         //                                             child: Text(
//                         //                                                 'anotha one'));
//                         //                                       },
//                         //                                     ),
//                         //                                   );
//                         //                                 },
//                         //                               );
//                         //                             },
//                         //                           );
//                         //                         },
//                         //                         child: Text('anotha one'));
//                         //                   },
//                         //                 ),
//                         //               );
//                         //             },
//                         //           );
//                         //         },
//                         //       );
//                         //     },
//                         //     child: Text('test')),

//                         SafeArea(
//                           child: Center(
//                             child: Wrap(
//                               children: [
//                                 InkWell(
//                                   borderRadius: BorderRadius.circular(2),
//                                   onTap: () {
//                                     // Navigator.of(context)
//                                     //     .pushNamed(Routes.signup);
//                                   },
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(5),
//                                     child: Center(
//                                       child: StandardTextButton(
//                                         onPressed: () {
//                                           //Unsure if this is the best way to do it but keep for now

//                                           setState(() {
//                                             context
//                                                 .read<NavigationCubit>()
//                                                 .push(NamedRoutes.domain,
//                                                     {'source': 'Login'});
//                                           });
//                                         },
//                                         label: Text(
//                                           'domain'.tr(),
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .labelLarge!
//                                               .copyWith(fontSize: 12),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class WidgetSignin extends StatefulWidget {
//   const WidgetSignin({Key? key}) : super(key: key);

//   @override
//   _WidgetSigninState createState() => _WidgetSigninState();
// }

// class _WidgetSigninState extends State<WidgetSignin> {
//   late SigninBloc _signinBloc;

//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _domainController = TextEditingController();

//   String? result = "";
//   String? refreshToken = "";
//   int? refresh;

//   bool? fetched = false;

//   bool? _saveEmail = false;

//   bool isAuthenticated = false;

//   // UserInfo? userInfo;

//   bool _loginError = false;
//   String? errorMessage;
//   bool _isButtonEnabled = false;

//   void _validateInput() {
//     setState(() {
//       _isButtonEnabled = _emailController.text.trim().isNotEmpty &&
//           _passwordController.text.trim().isNotEmpty;
//     });
//   }

//   @override
//   void initState() {
//     if (!kReleaseMode) {
//       if (AppConfig.shared.baseDomain.isEmpty) {
//         context
//             .read<NavigationCubit>()
//             .push(NamedRoutes.domain, {'source': 'initialSetup'});
//       }
//     } else {
//       setProductionDomain();
//     }

//     loadSetting();

//     _emailController.addListener(_validateInput);
//     _passwordController.addListener(_validateInput);

//     // Initial check (in case email is auto-filled from SharedPreferences)
//     _validateInput();

//     AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);

//     _domainController.text = AppConfig.shared.baseDomain;

//     _signinBloc = SigninBloc(
//         authBloc: authBloc,
//         authUsecase: getIt<AuthUsecaseType>(),
//         currentUserUsecase: getIt<CurrentUserUsecaseType>());

//     super.initState();
//   }

//   void setProductionDomain() async {
//     const domain = 'https://client.coamplifi.com';
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('domain', domain);
//     AppConfig(domain);
//   }

//   void rememberUsername(bool val) async {
//     final prefs = await SharedPreferences.getInstance();
//     // prefs.clear();
//     await prefs.setBool('saveEmail', val);

//     setState(() {
//       _saveEmail = val;
//     });
//   }

//   void loadSetting() async {
//     final prefs = await SharedPreferences.getInstance();
//     // prefs.clear();
//     bool emailPref = prefs.getBool('saveEmail') ?? false;

//     setState(() {
//       _saveEmail = emailPref;

//       if (emailPref) {
//         _emailController.text = prefs.getString('email') ?? '';
//       }
//     });
//   }

//   _passwordExpiredDialog(BuildContext context) {
//     String exitText = "Reset Password";

//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const TextWidget(
//               text: 'Password Expired',
//               color: Colors.grey,
//             ),
//             content: const SingleChildScrollView(
//                 child: Column(
//               children: [
//                 Text('Would you like to reset your password right now?'),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Text(
//                     'You can also recover your password at anytime using the forgot password button.'),
//               ],
//             )),
//             actions: <Widget>[
//               StandardTextButton(
//                 onPressed: () => {Navigator.pop(context, 'OK')},
//                 label: const Text('Cancel'),
//               ),
//               StandardTextButton(
//                 onPressed: () => {
//                   Navigator.pop(context, 'OK'),
//                   context
//                       .read<NavigationCubit>()
//                       .push(NamedRoutes.changePassword, {
//                     'userId': _emailController.text,
//                     'email': _emailController.text,
//                     'source': 'Login'
//                   })
//                 },
//                 label: Text(exitText),
//               ),
//             ],
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<SigninBloc, SigninState>(
//         bloc: _signinBloc,
//         listener: (BuildContext context, SigninState state) {
//           if (state is FailureSigninState) {
//             if (state.error != 'password_expired') {
//               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                 content: Text('Error, ${state.error}'),
//                 backgroundColor: Colors.redAccent,
//               ));
//             } else {
//               _passwordExpiredDialog(context);
//             }
//           }
//         },
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               'email_dot'.tr(),
//               style: kInputTextStyle,
//             ),
//             AutoValidateCustomTextFormField(
//               autovalidateMode: AutovalidateMode.always,
//               controller: _emailController,
//               hintText: 'email',
//               keyboardType: TextInputType.emailAddress,
//               validator: (text) {
//                 if (text.toString().isEmpty) {
//                   return 'Missing email';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Text(
//               'password_dot'.tr(),
//               style: kInputTextStyle,
//             ),
//             AutoValidateCustomTextFormField(
//               autovalidateMode: AutovalidateMode.always,
//               controller: _passwordController,
//               hintText: 'password',
//               obscureText: true,
//               validator: (text) {
//                 if (text.toString().isEmpty) {
//                   return 'Missing password';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             if (!kReleaseMode)
//               Text(
//                 'domain'.tr(),
//                 style: kInputTextStyle,
//               ),
//             if (!kReleaseMode) Text(AppConfig.shared.baseDomain),
//             const SizedBox(
//               height: 35,
//             ),
//             if (_loginError)
//               Text(
//                 errorMessage!,
//                 style: const TextStyle(color: Colors.red),
//               ),
//             BlocBuilder<SigninBloc, SigninState>(
//               bloc: _signinBloc,
//               builder: (BuildContext context, SigninState state) {
//                 return Center(
//                   child: CustomButton(
//                       fillColor:
//                           (_isButtonEnabled && state is! LoadingSigninState)
//                               ? null
//                               : StyleDictionaryColor.systemColorsActionDisabled,
//                       onPressed: (_isButtonEnabled &&
//                               state is! LoadingSigninState)
//                           ? () {
//                               _signinBloc.add(SigninButtonPressed(
//                                   _emailController.text,
//                                   _passwordController.text,
//                                   'CURAESOFT'));
//                               state is LoadingSigninState
//                                   ? null
//                                   : () => _signinBloc.add(SigninButtonPressed(
//                                       _emailController.text,
//                                       _passwordController.text,
//                                       'CURAESOFT'));
//                             }
//                           : null,
//                       text: state is LoadingSigninState
//                           ? 'Loading...'
//                           : 'Login'.tr()),
//                 );
//               },
//             ),
//             CheckboxListTile(
//               title: Text("Remember Email"), //    <-- label
//               value: _saveEmail,
//               onChanged: (newValue) {
//                 rememberUsername(newValue!);
//               },
//               controlAffinity: ListTileControlAffinity.leading,
//             ),
//           ],
//         ));
//   }

//   @override
//   void dispose() {
//     _signinBloc.close();
//     //_verificationNotifier.close();
//     super.dispose();
//   }
// }
