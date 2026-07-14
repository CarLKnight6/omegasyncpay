// import 'package:coamplifi_pro/model/job.dart';
// import 'package:coamplifi_pro/presentation/theme/constants.dart';
// import 'package:flutter/material.dart';

// Color getJobStatus(String status, bool isExpired) {
//   switch (status) {
//     case 'Active':
//       return isExpired
//           ? StyleDictionaryColor.error
//           : StyleDictionaryColor.primary;
//     case 'Planned':
//       return Colors.blue;
//     case 'Completed':
//       return StyleDictionaryColor.systemColorsSuccessMain;
//     default:
//       return Colors.grey;
//   }
// }

// String getJobStatusUiValue(String status) {
//   switch (status) {
//     case 'PrePlan':
//       return 'Proposal';
//     case 'Planned':
//       return 'In Plan';
//     case 'Active':
//       return 'Active';
//     case 'Onhold':
//       return 'On Hold';
//     case 'Completed':
//       return 'Completed';
//     case 'Closed':
//       return 'Validated';
//     case 'Terminated':
//       return 'Terminated';
//     case 'Void':
//       return 'Deleted';
//     default:
//       return status;
//   }
// }

// bool isJobEditable({
//   required String jobStatus,
//   required bool isExpired,
//   required bool isJobOwner,
//   required bool isProjectOwner,
//   required String projectStatus,
// }) {
//   const validProjectStatuses = ['Active', 'Planned', 'PrePlan'];
//   const editableJobStatuses = ['Closed', 'Terminated', 'Onhold', 'Void'];

//   if (isExpired) return false;

//   return (isProjectOwner &&
//           validProjectStatuses.contains(projectStatus) &&
//           !editableJobStatuses.contains(jobStatus)) ||
//       (isJobOwner && jobStatus == 'PrePlan');
// }

// List<Job> sortJobs(List<Job> jobs, String sortType) {
//   const priorityOrder = {
//     'Highest': 0,
//     'High': 1,
//     'Medium': 2,
//     'Low': 3,
//     'Lowest': 4,
//   };

//   final sorted = List<Job>.from(jobs);

//   switch (sortType) {
//     case 'priority_high_low':
//       sorted.sort((a, b) => (priorityOrder[a.priority] ?? 2)
//           .compareTo(priorityOrder[b.priority] ?? 2));
//     case 'priority_low_high':
//       sorted.sort((a, b) => (priorityOrder[b.priority] ?? 2)
//           .compareTo(priorityOrder[a.priority] ?? 2));
//   }

//   return sorted;
// }
