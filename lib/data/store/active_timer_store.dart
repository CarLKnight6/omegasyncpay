// import 'dart:convert';

// import 'package:coamplifi_pro/domain/quick_start_timer/active_timer_session.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// const kActiveTimerSessionKey = 'active_timer_session';
// const kTimerFinishingKey = 'timer_finishing';
// const kTimerPausedAtKey = 'timer_paused_at';
// const kTimerManagedKey = 'timer_managed';

// class ActiveTimerStore {
//   Future<ActiveTimerSession?> read() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.reload();
//     final raw = prefs.getString(kActiveTimerSessionKey);
//     if (raw == null || raw.isEmpty) return null;
//     try {
//       return ActiveTimerSession.fromJson(
//         jsonDecode(raw) as Map<String, dynamic>,
//       );
//     } catch (_) {
//       await clear();
//       return null;
//     }
//   }

//   Future<void> save(ActiveTimerSession session) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(
//       kActiveTimerSessionKey,
//       jsonEncode(session.toJson()),
//     );
//   }

//   Future<void> clear() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(kActiveTimerSessionKey);
//     await prefs.remove(kTimerPausedAtKey);
//     await prefs.remove(kTimerManagedKey);
//   }

//   /// Quick-start / notification timer is active across isolates and activities.
//   Future<void> markManaged() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(kTimerManagedKey, true);
//   }

//   Future<bool> isManaged() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.reload();
//     return prefs.getBool(kTimerManagedKey) ?? false;
//   }

//   Future<void> clearManaged() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(kTimerManagedKey);
//   }

//   /// UTC ISO timestamp when the timer was paused (cross-isolate freeze marker).
//   Future<void> markPausedAt(String isoUtc) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(kTimerPausedAtKey, isoUtc);
//   }

//   Future<String?> readPausedAt() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.reload();
//     return prefs.getString(kTimerPausedAtKey);
//   }

//   Future<void> clearPausedAt() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(kTimerPausedAtKey);
//   }

//   /// Set while a notification Finish action is in flight (cross-isolate guard).
//   Future<void> markFinishing() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(kTimerFinishingKey, true);
//   }

//   Future<bool> isFinishing() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.reload();
//     return prefs.getBool(kTimerFinishingKey) ?? false;
//   }

//   Future<void> clearFinishing() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(kTimerFinishingKey);
//   }
// }
