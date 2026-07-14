// part of 'my_jobs_bloc.dart';

// sealed class MyJobsEvent extends Equatable {
//   const MyJobsEvent();

//   @override
//   List<Object> get props => [];
// }

// class LoadMyJobs extends MyJobsEvent {}

// class SelectProject extends MyJobsEvent {
//   final String projectId;
//   final int index;
//   final int jobIndex;
//   final bool isEditable;
//   final Job jobData;
//   final ProjectsListDTO? projectDTO;
//   final bool isAddingNewJob;
//   final bool isFiltering;

//   const SelectProject(
//     this.projectId,
//     this.index,
//     this.jobIndex,
//     this.isEditable,
//     this.jobData, {
//     this.projectDTO,
//     this.isAddingNewJob = false,
//     this.isFiltering = false,
//   });
// }

// class ClearProjectSelection extends MyJobsEvent {}

// class FilterMyJobs extends MyJobsEvent {
//   final DateTimeRange<DateTime>? dateRange;
//   final List<String>? statusFilterList;
//   final List<String>? priorityFilterList;
//   final String? selectedMembership;
//   final String? clientId;
//   final String? accountId;
//   final String? projectId;
//   final String? deliverableId;
//   const FilterMyJobs(
//       {required this.dateRange,
//       required this.statusFilterList,
//       required this.priorityFilterList,
//       required this.selectedMembership,
//       required this.accountId,
//       required this.clientId,
//       required this.deliverableId,
//       required this.projectId});
// }

// class StartJobEvent extends MyJobsEvent {
//   final String projectId;
//   final String jobId;
//   final String details;
//   final String estimateUnit;
//   final int estimateValue;

//   const StartJobEvent({
//     required this.projectId,
//     required this.jobId,
//     required this.details,
//     required this.estimateUnit,
//     required this.estimateValue,
//   });
// }

// class ToggleJobExpansion extends MyJobsEvent {
//   final int index;
//   final bool expanded;
//   const ToggleJobExpansion(this.index, this.expanded);
// }

// class AddNewJob extends MyJobsEvent {
//   final JobPayloadDTO jobPayloadDTO;
//   const AddNewJob({required this.jobPayloadDTO});
// }

// class AddJob extends MyJobsEvent {
//   final Map<String, dynamic> payload;

//   const AddJob({required this.payload});
// }

// class UpdateJob extends MyJobsEvent {
//   final Map<String, dynamic> payload;
//   final String jobid;
//   const UpdateJob({required this.payload, required this.jobid});
// }

// class SearchMyJobs extends MyJobsEvent {
//   final String query;

//   SearchMyJobs(this.query);
// }

// class LoadNotes extends MyJobsEvent {
//   final String jobId;

//   const LoadNotes({required this.jobId});

//   @override
//   List<Object> get props => [jobId];
// }

// class AddJobNote extends MyJobsEvent {
//   final Map<String, dynamic> payload;

//   const AddJobNote({required this.payload});

//   @override
//   List<Object> get props => [payload];
// }

// class EditJobNote extends MyJobsEvent {
//   final String jobId;
//   final String noteId;
//   final Map<String, dynamic> payload;

//   const EditJobNote({
//     required this.jobId,
//     required this.noteId,
//     required this.payload,
//   });

//   @override
//   List<Object> get props => [jobId, noteId, payload];
// }

// class DeleteJobNote extends MyJobsEvent {
//   final String noteId;

//   const DeleteJobNote({required this.noteId});

//   @override
//   List<Object> get props => [noteId];
// }

// class SortMyJobs extends MyJobsEvent {
//   final String sortType;

//   const SortMyJobs({required this.sortType});

//   @override
//   List<Object> get props => [sortType];
// }
