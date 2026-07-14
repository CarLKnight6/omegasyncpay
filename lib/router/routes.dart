// import 'package:coamplifi_pro/pages/forgot/forgot_password_page.dart';
// import 'package:coamplifi_pro/pages/settings/comm_tabs.dart';
// import 'package:coamplifi_pro/pages/settings/advanced_settings_page.dart';
// import 'package:coamplifi_pro/pages/settings/doman_settings_page.dart';
// import 'package:coamplifi_pro/pages/settings/localization_settings.dart';
// import 'package:coamplifi_pro/pages/settings/navigation_settings.dart';
// import 'package:coamplifi_pro/pages/settings/notification_settings.dart';
// import 'package:coamplifi_pro/pages/settings/password_settings.dart';
// import 'package:coamplifi_pro/pages/settings/profile_settings.dart';
// import 'package:coamplifi_pro/pages/settings/security_settings.dart';
// import 'package:coamplifi_pro/pages/settings/settings_page.dart';
// import 'package:coamplifi_pro/pages/settings/theme_custom_page.dart';
// import 'package:coamplifi_pro/pages/settings/theme_settings.dart';
// import 'package:coamplifi_pro/presentation/auth/signin/signin_screen.dart';
// import 'package:coamplifi_pro/presentation/projects/pages/job_card_list.dart';
// import 'package:coamplifi_pro/presentation/projects/pages/projects_details_page.dart';
// import 'package:coamplifi_pro/presentation/projects/pages/projects_page.dart';
// import 'package:coamplifi_pro/presentation/projects/pages/task_list_table_page.dart';
// import 'package:coamplifi_pro/presentation/splash/presentation/splash_page.dart';
// import 'package:coamplifi_pro/presentation/timeclock/widgets/kpi_graph.dart';
// import '../pages/settings/network_page.dart';
// import '../presentation/home/home.dart';
// import 'cs_pages/cs_page.dart';
// import 'page_config.dart';

// ///thanks dart for being multi-paradigm
// CSPage? getCSPage(PageConfig config) {
//   //print('looking for ${config.route}');

//   //CSPage p = _routes[config.route]?.call(config.args) ?? CSNotFoundPage(config.args);

//   CSPage? p = _routes[config.route]?.call(config.args);

//   //print('found $p');
//   return p;
// }

// Map<String, CSPage Function(Map<String, dynamic>)> _routes = {
//   '/splash': (args) => CSPage(args: args, child: SplashScreen()),
//   '/login': (args) => CSPage(args: args, child: const SigninScreen()),
//   '/home': (args) => CSPage(args: args, child: const Home2()),
//   '/projects': (args) => CSPage(
//       args: args,
//       child: ProjectsPage(
//         withAppBar: args['withAppBar'],
//       )),
//   '/settings': ((args) => CSPage(args: args, child: SettingsPage())),
//   '/projectDetails': (args) => CSPage(
//       args: args,
//       child: ProjectsDetailsPage(
//           canEdit: args['canEdit'],
//           projectDetails: args['projectDetails'],
//           projectsUsecase: args['projectsUsecase'],
//           projectsOverviewContext: args['projectsOverviewContext'])),
//   '/taskListTablePage': (args) => CSPage(
//       args: args,
//       child: TaskListTablePage(
//         context: args['context'],
//         loadedTasks: args['loadedTasks'],
//       )),
//   '/jobCardListPage': (args) => CSPage(
//       args: args,
//       child: JobCardListPage(
//         projectsUsecase: args['projectsUsecase'],
//         projectsOverviewContext: args['projectsOverviewContext'],
//         location: args['location'],
//         jobsList: args['jobsList'],
//         unitName: args['unitName'],
//         members: args['members'],
//         canEdit: args['canEdit'],
//       )),
//   '/theme-setting': (args) => CSPage(args: args, child: ThemeSettingPage()),
//   '/security-setting': (args) =>
//       CSPage(args: args, child: SecuritySettingPage()),
//   '/comms': (args) => CSPage(args: args, child: CommsPage()),
//   '/network_status': (args) => CSPage(args: args, child: NetworkStatusPage()),
//   '/domain-setting': (args) => CSPage(
//       args: args,
//       child: DomainSettingPage(
//         source: args['source'],
//       )),
//   '/profile-setting': (args) =>
//       CSPage(args: args, child: const ProfileSettingPage()),
//   '/localization-setting': (args) =>
//       CSPage(args: args, child: LocalizationSettings()),
//   '/forgot_password': (args) =>
//       CSPage(args: args, child: ForgotPasswordPage(reset: args['reset'])),
//   '/custom_theme': (args) =>
//       CSPage(args: args, child: ThemeCustomSettingPage()),
//   '/navigation_setting': (args) =>
//       CSPage(args: args, child: const NavigationSetting()),
//   '/advanced_settings': (args) => CSPage(args: args, child: AdvancedSettings()),
//   '/password_settings': (args) => CSPage(
//       args: args,
//       child: PasswordSettingsPage(
//         userId: args['userId'].toString() ?? "",
//         email: args['email']?.toString() ?? "",
//         source: args['source']?.toString() ?? "Login",
//       )),
//   '/kpiGraph': (args) => CSPage(
//       args: args,
//       child: KPIGraph(
//         timecard: args['timecard'],
//       )),
//   '/notification_settings': (args) =>
//       CSPage(args: args, child: const NotificationsSettings()),
// };
