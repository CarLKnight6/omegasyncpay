// part of 'my_jobs_bloc.dart';

// class MyJobsAppliedFilters extends Equatable {
//   final String? selectedMembership;
//   final List<String> statusFilterList;
//   final List<String> priorityFilterList;
//   final String? clientId;
//   final String? accountId;
//   final String? projectId;
//   final String? deliverableId;
//   final DateTimeRange? dateRange;

//   const MyJobsAppliedFilters({
//     this.selectedMembership = 'member',
//     this.statusFilterList = const ['Planned', 'Active'],
//     this.priorityFilterList = const [],
//     this.clientId,
//     this.accountId,
//     this.projectId,
//     this.deliverableId,
//     this.dateRange,
//   });

//   static const defaults = MyJobsAppliedFilters();

//   factory MyJobsAppliedFilters.fromFilterEvent(FilterMyJobs event) {
//     return MyJobsAppliedFilters(
//       selectedMembership: event.selectedMembership,
//       statusFilterList: List<String>.from(event.statusFilterList ?? []),
//       priorityFilterList: List<String>.from(event.priorityFilterList ?? []),
//       clientId: _nonEmpty(event.clientId),
//       accountId: _nonEmpty(event.accountId),
//       projectId: _nonEmpty(event.projectId),
//       deliverableId: _nonEmpty(event.deliverableId),
//       dateRange: event.dateRange,
//     );
//   }

//   static String? _nonEmpty(String? value) {
//     if (value == null || value.isEmpty) return null;
//     return value;
//   }

//   @override
//   List<Object?> get props => [
//         selectedMembership,
//         statusFilterList,
//         priorityFilterList,
//         clientId,
//         accountId,
//         projectId,
//         deliverableId,
//         dateRange,
//       ];
// }

// class MyJobsState extends Equatable {
//   final List<Job> jobs;
//   final List<ProjectsListDTO> projects;
//   final List<Client> clients;
//   final Set<int> expandedTiles;
//   final Job? job;
//   final String searchQuery;
//   final bool isClearSearchField;
//   final CurrentUserInfo? currentUserInfo;
//   final List<NotesDTO>? notes;
//   final String sortType;
//   final ProjectsListDTO? projectDTO;
//   final MyJobsAppliedFilters appliedFilters;
//   const MyJobsState({
//     required this.jobs,
//     required this.projects,
//     this.clients = const [],
//     this.expandedTiles = const {},
//     this.job,
//     this.searchQuery = '',
//     this.isClearSearchField = false,
//     this.currentUserInfo,
//     this.notes = const [],
//     this.sortType = 'none',
//     this.projectDTO,
//     this.appliedFilters = MyJobsAppliedFilters.defaults,
//   });

//   MyJobsState copyWith({
//     List<Job>? jobs,
//     List<ProjectsListDTO>? projects,
//     List<Client>? clients,
//     Set<int>? expandedTiles,
//     String? searchQuery,
//     bool? isClearSearchField,
//     CurrentUserInfo? currentUserInfo,
//     List<NotesDTO>? notes,
//     String? sortType,
//     MyJobsAppliedFilters? appliedFilters,
//   }) {
//     return MyJobsState(
//       jobs: jobs ?? this.jobs,
//       projects: projects ?? this.projects,
//       clients: clients ?? this.clients,
//       expandedTiles: expandedTiles ?? this.expandedTiles,
//       searchQuery: searchQuery ?? this.searchQuery,
//       isClearSearchField: isClearSearchField ?? this.isClearSearchField,
//       currentUserInfo: currentUserInfo ?? this.currentUserInfo,
//       notes: notes ?? this.notes,
//       sortType: sortType ?? this.sortType,
//       projectDTO: projectDTO ?? projectDTO,
//       appliedFilters: appliedFilters ?? this.appliedFilters,
//     );
//   }

//   @override
//   List<Object> get props => [
//         jobs,
//         projects,
//         clients,
//         expandedTiles,
//         searchQuery,
//         isClearSearchField,
//         notes ?? [],
//         sortType,
//         appliedFilters,
//       ];
// }

// final class SelectedProjectLoaded extends MyJobsState {
//   final List<Deliverable> deliverableData;
//   final CurrentUserInfo currentUserInfo;
//   final int index;
//   final int jobIndex;
//   final bool isEditable;
//   final Job jobData;
//   final String sortType;
//   final ProjectsListDTO? projectDTO;
//   final bool isAddingNewJob;
//   final bool isFiltering;
//   final PlannerServiceGeneralTasklistDTO generalTaskList;

//   SelectedProjectLoaded({
//     required this.deliverableData,
//     required this.currentUserInfo,
//     required this.index,
//     required this.jobIndex,
//     required this.jobData,
//     this.isEditable = true,
//     required List<Job> jobs,
//     required List<ProjectsListDTO> projects,
//     required List<Client> clients,
//     required Set<int> expandedTiles,
//     String searchQuery = '',
//     this.sortType = 'none',
//     this.projectDTO,
//     this.isAddingNewJob = false,
//     this.isFiltering = false,
//     required this.generalTaskList,
//     MyJobsAppliedFilters appliedFilters = MyJobsAppliedFilters.defaults,
//   }) : super(
//             jobs: jobs,
//             projects: projects,
//             clients: clients,
//             expandedTiles: expandedTiles,
//             currentUserInfo: currentUserInfo,
//             searchQuery: searchQuery,
//             sortType: sortType,
//             projectDTO: projectDTO,
//             appliedFilters: appliedFilters);

//   @override
//   List<Object> get props => [
//         deliverableData,
//         currentUserInfo,
//         index,
//         jobIndex,
//         jobData,
//         jobs,
//         projects,
//         clients,
//         expandedTiles,
//         isEditable,
//         searchQuery,
//         sortType,
//         projectDTO ?? ProjectsListDTO(),
//         isAddingNewJob,
//         isFiltering,
//         generalTaskList,
//       ];
// }

// final class AddNewJobSucess extends MyJobsState {
//   AddNewJobSucess({
//     required List<Job> jobs,
//     required List<ProjectsListDTO> projects,
//     required List<Client> clients,
//     required Set<int> expandedTiles,
//     required CurrentUserInfo? currentUserInfo,
//     Job? job,
//   }) : super(
//             jobs: jobs,
//             projects: projects,
//             clients: clients,
//             expandedTiles: expandedTiles,
//             job: job,
//             currentUserInfo: currentUserInfo);

//   @override
//   List<Object> get props => [jobs, projects, clients, expandedTiles, job ?? ''];
// }

// final class AddNewJobError extends MyJobsState {
//   final String? message;

//   AddNewJobError({this.message})
//       : super(jobs: [], projects: [], clients: [], expandedTiles: {});

//   @override
//   List<Object> get props => [message ?? ''];
// }

// final class MyJobsRefreshTimecard extends MyJobsState {
//   final Timecard timecard;

//   MyJobsRefreshTimecard(
//     this.timecard, {
//     required super.jobs,
//     required super.projects,
//     required super.clients,
//     super.expandedTiles,
//     super.searchQuery,
//     super.isClearSearchField,
//     super.currentUserInfo,
//     super.notes,
//     super.sortType,
//     super.appliedFilters,
//   });

//   @override
//   List<Object> get props => [...super.props, timecard];
// }

// final class MyJobsInitial extends MyJobsState {
//   MyJobsInitial()
//       : super(jobs: [], projects: [], clients: [], expandedTiles: {});

//   @override
//   List<Object> get props => [];
// }

// final class MyJobsLoaded extends MyJobsState {
//   const MyJobsLoaded({
//     required super.jobs,
//     required super.projects,
//     super.expandedTiles,
//     super.clients,
//     super.searchQuery,
//     super.isClearSearchField,
//     required super.currentUserInfo,
//     super.notes,
//     super.sortType,
//     super.appliedFilters,
//   });

//   @override
//   MyJobsLoaded copyWith({
//     List<Job>? jobs,
//     List<ProjectsListDTO>? projects,
//     List<Client>? clients,
//     Set<int>? expandedTiles,
//     String? searchQuery,
//     bool? isClearSearchField,
//     CurrentUserInfo? currentUserInfo,
//     List<NotesDTO>? notes,
//     String? sortType,
//     MyJobsAppliedFilters? appliedFilters,
//   }) {
//     return MyJobsLoaded(
//       jobs: jobs ?? this.jobs,
//       projects: projects ?? this.projects,
//       clients: clients ?? this.clients,
//       expandedTiles: expandedTiles ?? this.expandedTiles,
//       searchQuery: searchQuery ?? this.searchQuery,
//       isClearSearchField: isClearSearchField ?? this.isClearSearchField,
//       currentUserInfo: currentUserInfo ?? this.currentUserInfo,
//       notes: notes ?? this.notes,
//       sortType: sortType ?? this.sortType,
//       appliedFilters: appliedFilters ?? this.appliedFilters,
//     );
//   }

//   @override
//   List<Object> get props => [
//         jobs,
//         projects,
//         expandedTiles,
//         clients,
//         searchQuery,
//         isClearSearchField,
//         currentUserInfo ?? '',
//         notes ?? [],
//         sortType,
//         appliedFilters,
//       ];
// }

// final class MyJobsError extends MyJobsState {
//   final String? message;

//   MyJobsError({this.message})
//       : super(jobs: [], projects: [], clients: [], expandedTiles: {});

//   @override
//   List<Object> get props => [message ?? ''];
// }
