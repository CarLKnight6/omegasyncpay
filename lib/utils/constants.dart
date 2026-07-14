// import 'package:coamplifi_pro/utils/util.dart';
// import 'package:flutter/material.dart'
//     show Color, Colors, FontStyle, FontWeight, TextStyle;

// import '../config/app_config.dart';
// import 'package:coamplifi_pro/presentation/theme/design_token.dart';

// export 'package:coamplifi_pro/presentation/theme/constants.dart';
// // ! Style variables should be in lib/presentation/theme/constants.dart.
// // ! We keep the export for backward compatibility.
// // ! In the future, we should remove the export and use lib/presentation/theme/constants.dart exclusively for styling.

// String query = '';

// final taskPriorityColors = {
//   "Critical": StyleDictionaryColor.systemColorsErrorMain,
//   "Important": StyleDictionaryColor.systemColorsWarningMain,
//   "Normal": StyleDictionaryColor.systemColorsInfoMain,
//   "Low": StyleDictionaryColor.systemColorsSuccessMain,
//   "Unknown": StyleDictionaryColor.systemColorsPrimaryMain,
// };

// String defaultAvatar =
//     '${AppConfig.shared.baseDomain}/en-US/assets/images/users/default-avatar.jpeg';

// const ptoConst = {
//   'PTO_NAME_PREFIX': 'PTO:',
//   'PTO_FULL_DAY': 'PTO: Full Day',
//   'PAID_TIME_OFF': 'Paid Time Off',
// };

// List<Map<String, dynamic>> targetLengthOptions = [
//   {"display": "1 min", "targetMinutes": 1, "durationDisplay": "00:01"},
//   {"display": "2 mins", "targetMinutes": 2, "durationDisplay": "00:02"},
//   {"display": "3 mins", "targetMinutes": 3, "durationDisplay": "00:03"},
//   {"display": "4 mins", "targetMinutes": 4, "durationDisplay": "00:04"},
//   {"display": "5 mins", "targetMinutes": 5, "durationDisplay": "00:05"},
//   {"display": "10 mins", "targetMinutes": 10, "durationDisplay": "00:10"},
//   {"display": "15 mins", "targetMinutes": 15, "durationDisplay": "00:15"},
//   {"display": "20 mins", "targetMinutes": 20, "durationDisplay": "00:20"},
//   {"display": "30 mins", "targetMinutes": 30, "durationDisplay": "00:30"},
//   {"display": "45 mins", "targetMinutes": 45, "durationDisplay": "00:45"},
//   {"display": "1 hour", "targetMinutes": 60, "durationDisplay": "01:00"},
//   {
//     "display": "1 hour 15 mins",
//     "targetMinutes": 75,
//     "durationDisplay": "01:15"
//   },
//   {
//     "display": "1 hour 30 mins",
//     "targetMinutes": 90,
//     "durationDisplay": "01:30"
//   },
//   {
//     "display": "1 hour 45 mins",
//     "targetMinutes": 105,
//     "durationDisplay": "01:45"
//   },
//   {"display": "2 hours", "targetMinutes": 120, "durationDisplay": "02:00"},
//   {
//     "display": "2 hours 30 mins",
//     "targetMinutes": 150,
//     "durationDisplay": "02:30"
//   },
//   {"display": "3 hours", "targetMinutes": 180, "durationDisplay": "03:00"},
//   {
//     "display": "3 hours 30 mins",
//     "targetMinutes": 210,
//     "durationDisplay": "03:30"
//   },
//   {"display": "4 hours", "targetMinutes": 240, "durationDisplay": "04:00"},
//   {
//     "display": "4 hours 30 mins",
//     "targetMinutes": 270,
//     "durationDisplay": "04:30"
//   },
//   {"display": "5 hours", "targetMinutes": 300, "durationDisplay": "05:00"},
//   {
//     "display": "5 hours 30 mins",
//     "targetMinutes": 330,
//     "durationDisplay": "05:30"
//   },
//   {"display": "6 hours", "targetMinutes": 360, "durationDisplay": "06:00"},
//   {
//     "display": "6 hours 30 mins",
//     "targetMinutes": 390,
//     "durationDisplay": "06:30"
//   },
//   {"display": "7 hours", "targetMinutes": 420, "durationDisplay": "07:00"},
//   {
//     "display": "7 hours 30 mins",
//     "targetMinutes": 450,
//     "durationDisplay": "07:30"
//   },
//   {"display": "8 hours", "targetMinutes": 480, "durationDisplay": "08:00"},
// ];

// List<Map<String, dynamic>> repeatOptions = [
//   {'value': 'Daily', 'display': 'daily'.tr()},
//   {'value': 'Weekly', 'display': 'weekly'.tr()},
//   {'value': 'Monthly', 'display': 'monthly'.tr()},
//   {'value': 'Yearly', 'display': 'yearly'.tr()},
// ];

// List<Map<String, String>> weeklyDayOfWeekOptions = [
//   {"display": "Sunday", "value": "SU"},
//   {"display": "Monday", "value": "MO"},
//   {"display": "Tuesday", "value": "TU"},
//   {"display": "Wednesday", "value": "WE"},
//   {"display": "Thursday", "value": "TH"},
//   {"display": "Friday", "value": "FR"},
//   {"display": "Saturday", "value": "SA"},
// ];

// List<Map<String, String>> monthlyDayOfWeekOptions = [
//   {"display": "1st Sunday", "value": "1SU"},
//   {"display": "1st Monday", "value": "1MO"},
//   {"display": "1st Tuesday", "value": "1TU"},
//   {"display": "1st Wednesday", "value": "1WE"},
//   {"display": "1st Thursday", "value": "1TH"},
//   {"display": "1st Friday", "value": "1FR"},
//   {"display": "1st Saturday", "value": "1SA"},
//   {"display": "2nd Sunday", "value": "2SU"},
//   {"display": "2nd Monday", "value": "2MO"},
//   {"display": "2nd Tuesday", "value": "2TU"},
//   {"display": "2nd Wednesday", "value": "2WE"},
//   {"display": "2nd Thursday", "value": "2TH"},
//   {"display": "2nd Friday", "value": "2FR"},
//   {"display": "2nd Saturday", "value": "2SA"},
//   {"display": "3rd Sunday", "value": "3SU"},
//   {"display": "3rd Monday", "value": "3MO"},
//   {"display": "3rd Tuesday", "value": "3TU"},
//   {"display": "3rd Wednesday", "value": "3WE"},
//   {"display": "3rd Thursday", "value": "3TH"},
//   {"display": "3rd Friday", "value": "3FR"},
//   {"display": "3rd Saturday", "value": "3SA"},
//   {"display": "4th Sunday", "value": "4SU"},
//   {"display": "4th Monday", "value": "4MO"},
//   {"display": "4th Tuesday", "value": "4TU"},
//   {"display": "4th Wednesday", "value": "4WE"},
//   {"display": "4th Thursday", "value": "4TH"},
//   {"display": "4th Friday", "value": "4FR"},
//   {"display": "4th Saturday", "value": "4SA"},
//   {"display": "5th Sunday", "value": "5SU"},
//   {"display": "5th Monday", "value": "5MO"},
//   {"display": "5th Tuesday", "value": "5TU"},
//   {"display": "5th Wednesday", "value": "5WE"},
//   {"display": "5th Thursday", "value": "5TH"},
//   {"display": "5th Friday", "value": "5FR"},
//   {"display": "5th Saturday", "value": "5SA"},
//   {"display": "Last Sunday", "value": "-1SU"},
//   {"display": "Last Monday", "value": "-1MO"},
//   {"display": "Last Tuesday", "value": "-1TU"},
//   {"display": "Last Wednesday", "value": "-1WE"},
//   {"display": "Last Thursday", "value": "-1TH"},
//   {"display": "Last Friday", "value": "-1FR"},
//   {"display": "Last Saturday", "value": "-1SA"},
//   {"display": "2nd to Last Sunday", "value": "-2SU"},
//   {"display": "2nd to Last Monday", "value": "-2MO"},
//   {"display": "2nd to Last Tuesday", "value": "-2TU"},
//   {"display": "2nd to Last Wednesday", "value": "-2WE"},
//   {"display": "2nd to Last Thursday", "value": "-2TH"},
//   {"display": "2nd to Last Friday", "value": "-2FR"},
//   {"display": "2nd to Last Saturday", "value": "-2SA"},
// ];

// List<Map<String, String>> dayOfMonthOptions = [
//   {"display": "1st day", "value": "1"},
//   {"display": "2nd day", "value": "2"},
//   {"display": "3rd day", "value": "3"},
//   {"display": "4th day", "value": "4"},
//   {"display": "5th day", "value": "5"},
//   {"display": "6th day", "value": "6"},
//   {"display": "7th day", "value": "7"},
//   {"display": "8th day", "value": "8"},
//   {"display": "9th day", "value": "9"},
//   {"display": "10th day", "value": "10"},
//   {"display": "11th day", "value": "11"},
//   {"display": "12th day", "value": "12"},
//   {"display": "13th day", "value": "13"},
//   {"display": "14th day", "value": "14"},
//   {"display": "15th day", "value": "15"},
//   {"display": "16th day", "value": "16"},
//   {"display": "17th day", "value": "17"},
//   {"display": "18th day", "value": "18"},
//   {"display": "19th day", "value": "19"},
//   {"display": "20th day", "value": "20"},
//   {"display": "21st day", "value": "21"},
//   {"display": "22nd day", "value": "22"},
//   {"display": "23rd day", "value": "23"},
//   {"display": "24th day", "value": "24"},
//   {"display": "25th day", "value": "25"},
//   {"display": "26th day", "value": "26"},
//   {"display": "27th day", "value": "27"},
//   {"display": "28th day", "value": "28"},
//   {"display": "29th day", "value": "29"},
//   {"display": "30th day", "value": "30"},
//   {"display": "31st day", "value": "31"},
//   {"display": "Last day", "value": "-1"},
//   {"display": "2nd to the last day", "value": "-2"},
//   {"display": "3rd to the last day", "value": "-3"},
//   {"display": "4th to the last day", "value": "-4"},
//   {"display": "5th to the last day", "value": "-5"},
//   {"display": "6th to the last day", "value": "-6"},
//   {"display": "7th to the last day", "value": "-7"},
//   {"display": "8th to the last day", "value": "-8"},
//   {"display": "9th to the last day", "value": "-9"},
//   {"display": "10th to the last day", "value": "-10"},
//   {"display": "11th to the last day", "value": "-11"},
//   {"display": "12th to the last day", "value": "-12"},
//   {"display": "13th to the last day", "value": "-13"},
//   {"display": "14th to the last day", "value": "-14"},
//   {"display": "15th to the last day", "value": "-15"},
// ];

// bool isTargetEndDatePassed(DateTime targetEndDate) {
//   final currentDate =
//       DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

//   final newTargetEndDate =
//       DateTime(targetEndDate.year, targetEndDate.month, targetEndDate.day);

//   return currentDate.isAfter(newTargetEndDate);
// }

// bool isStartEndDateArrives(DateTime startEndDate) {
//   final currentDate =
//       DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

//   final newStartEndDate =
//       DateTime(startEndDate.year, startEndDate.month, startEndDate.day);

//   return currentDate.isAfter(newStartEndDate);
// }

// const digitsAndSlash = r'^[0-9/]*$';
// const dateRegEx = r'^\d{1,2}/\d{1,2}/\d{4}$';

// enum ProjectStatus { PrePlan, Planned, Active }

// extension ProjectStatusExtension on ProjectStatus {
//   static ProjectStatus? fromString(String? status) {
//     switch (status) {
//       case 'PrePlan':
//         return ProjectStatus.PrePlan;
//       case 'Planned':
//         return ProjectStatus.Planned;
//       case 'Active':
//         return ProjectStatus.Active;
//       default:
//         return null;
//     }
//   }
// }

// enum TaskStatus { Open, Expired, Completed, InProgress, OnHold }

// extension TaskStatusExtension on TaskStatus {
//   static TaskStatus? fromString(String? status) {
//     switch (status) {
//       case 'Open':
//         return TaskStatus.Open;
//       case 'Expired':
//         return TaskStatus.Expired;
//       case 'Completed':
//         return TaskStatus.Completed;
//       case 'In Progress':
//         return TaskStatus.InProgress;
//       case 'On Hold':
//         return TaskStatus.OnHold;
//       default:
//         return null;
//     }
//   }
// }
