// import 'dart:developer';

// import 'package:bloc/bloc.dart';
// import 'package:coamplifi_pro/data/api/api_client/api_timecard_client_type.dart';
// import 'package:coamplifi_pro/data/dto/job_payload_dto.dart';
// import 'package:coamplifi_pro/data/dto/notes_dto.dart';
// import 'package:coamplifi_pro/data/dto/planner_service_general_tasklist_dto.dart';
// import 'package:coamplifi_pro/data/dto/projects_dto.dart';
// import 'package:coamplifi_pro/data/dto/timecard.dart';
// import 'package:coamplifi_pro/domain/auth/auth_usecase_type.dart';
// import 'package:coamplifi_pro/domain/auth/current_user_info.dart';
// import 'package:coamplifi_pro/domain/clipboard/clipboard_repository_type.dart';
// import 'package:coamplifi_pro/domain/clipboard/clipboard_usecase_type.dart';
// import 'package:coamplifi_pro/domain/projects/projects_usecase_type.dart';
// import 'package:coamplifi_pro/model/client.dart';
// import 'package:coamplifi_pro/model/deliverable.dart';
// import 'package:coamplifi_pro/model/job.dart';
// import 'package:coamplifi_pro/data/dto/calendar_event_dto.dart';
// import 'package:coamplifi_pro/model/taskboard.dart';

// import 'package:coamplifi_pro/utils/app_mixin.dart';
// import 'package:coamplifi_pro/utils/function/date_formatting.dart';
// import 'package:coamplifi_pro/utils/function/time_fn.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';

// part 'my_jobs_event.dart';
// part 'my_jobs_state.dart';

// class MyJobsBloc extends Bloc<MyJobsEvent, MyJobsState>
//     with ResponsiveMixin, RouteAware {
//   final APITimeCardClientType apiTimecardClient;
//   final ClipboardUsecaseType clipboardUsecase;
//   final AuthUsecaseType authUsecase;
//   final ProjectsUsecaseType projectsUsecase;
//   final ClipboardRepositoryType clipboardRepository;

//   MyJobsBloc(
//       {required this.apiTimecardClient,
//       required this.clipboardRepository,
//       required this.clipboardUsecase,
//       required this.authUsecase,
//       required this.projectsUsecase})
//       : super(MyJobsInitial()) {
//     on<AddNewJob>((event, emit) async {
//       try {
//         final job = await addNewJob(jobPayload: event.jobPayloadDTO);
//         emit(AddNewJobSucess(
//             job: job,
//             clients: state.clients,
//             expandedTiles: state.expandedTiles,
//             jobs: state.jobs,
//             projects: state.projects,
//             currentUserInfo: state.currentUserInfo));
//       } catch (e) {
//         emit(AddNewJobError(message: 'Error adding new job: $e'));
//       }
//     });

//     on<AddJob>(
//       (event, emit) async {
//         try {
//           final job = await addJob(payload: event.payload);

//           List<Job> jobs = [...state.jobs, job ?? Job()];

//           emit(MyJobsLoaded(
//             jobs: jobs,
//             projects: state.projects,
//             clients: state.clients,
//             expandedTiles: state.expandedTiles,
//             currentUserInfo: state.currentUserInfo,
//             appliedFilters: state.appliedFilters,
//           ));
//         } catch (e) {
//           emit(AddNewJobError(message: 'Error adding job: $e'));
//         }
//       },
//     );

//     on<UpdateJob>((event, emit) async {
//       try {
//         final job = await updateJob(jobId: event.jobid, payload: event.payload);
//         List<Job> jobs = state.jobs.map((e) {
//           if (e.id == event.jobid) {
//             return job?[0] ?? Job(id: event.jobid);
//           }
//           return e;
//         }).toList();

//         emit(MyJobsLoaded(
//           jobs: jobs,
//           projects: state.projects,
//           clients: state.clients,
//           expandedTiles: state.expandedTiles,
//           currentUserInfo: state.currentUserInfo,
//           appliedFilters: state.appliedFilters,
//         ));
//       } catch (e) {
//         emit(AddNewJobError(message: 'Error adding new job: $e'));
//       }
//     });

//     on<SearchMyJobs>((event, emit) {
//       emit(state.copyWith(searchQuery: event.query));
//     });

//     on<FilterMyJobs>((event, emit) async {
//       emit(MyJobsInitial());

//       final appliedFilters = MyJobsAppliedFilters.fromFilterEvent(event);
//       final currentUserInfo = await _getCurrentUser();
//       List<Client>? clients = await getClients();

//       final result = convertDateRange(event.dateRange);

//       final Map<String, dynamic> payload = {
//         "fromDate": result["fromDate"],
//         "toDate": result["toDate"],
//         "statuses": event.statusFilterList,
//         "priorities": event.priorityFilterList,
//         "contextUserId": currentUserInfo.userKey.aggregateId,
//         "memberType": event.selectedMembership,
//         "clientIds": event.clientId!.isNotEmpty ? [event.clientId] : [],
//         "accountIds": event.accountId!.isNotEmpty ? [event.accountId] : [],
//         "projectIds": event.projectId!.isNotEmpty ? [event.projectId] : [],
//         "deliverableIds":
//             event.deliverableId!.isNotEmpty ? [event.deliverableId] : [],
//       };
//       try {
//         final result = await apiTimecardClient.getJobs(requestPayload: payload);

//         final newState = MyJobsLoaded(
//           jobs: result.jobs ?? [],
//           projects: result.projects ?? [],
//           clients: clients ?? [],
//           expandedTiles: <int>{},
//           currentUserInfo: currentUserInfo,
//           appliedFilters: appliedFilters,
//         );

//         emit(newState.copyWith(searchQuery: '', isClearSearchField: true));
//       } catch (e) {
//         print('Error loading MyJobs data: $e');
//       }
//     });

//     on<SortMyJobs>((event, emit) {
//       emit(MyJobsLoaded(
//         jobs: state.jobs,
//         projects: state.projects,
//         clients: state.clients,
//         expandedTiles: state.expandedTiles,
//         currentUserInfo: state.currentUserInfo,
//         searchQuery: state.searchQuery,
//         sortType: event.sortType,
//         appliedFilters: state.appliedFilters,
//       ));
//     });

//     on<ClearProjectSelection>((event, emit) {
//       emit(MyJobsLoaded(
//           jobs: state.jobs,
//           projects: state.projects,
//           clients: state.clients,
//           expandedTiles: state.expandedTiles,
//           currentUserInfo: state.currentUserInfo,
//           searchQuery: state.searchQuery,
//           sortType: state.sortType,
//           appliedFilters: state.appliedFilters));
//     });
//     on<SelectProject>((event, emit) async {
//       final deliverableData = await getDeliverables(
//           includeAll: false, includeCount: false, projectId: event.projectId);
//       final currentUserInfo = await _getCurrentUser();
//       final generalTaskList = await _getGeneralTaskList();
//       Job job = event.jobData;

//       if (!event.isAddingNewJob) {
//         final taskStat = await getJobTaskStat(jobId: job.id ?? '');

//         if (taskStat != null) {
//           job.taskStatDTO = taskStat;
//         }
//       }

//       emit(SelectedProjectLoaded(
//           jobData: job,
//           jobIndex: event.jobIndex,
//           index: event.index,
//           deliverableData: deliverableData ?? [],
//           currentUserInfo: currentUserInfo,
//           jobs: state.jobs,
//           projects: state.projects,
//           clients: state.clients,
//           expandedTiles: state.expandedTiles,
//           searchQuery: state.searchQuery,
//           sortType: state.sortType,
//           isEditable: event.isEditable,
//           projectDTO: event.projectDTO,
//           isAddingNewJob: event.isAddingNewJob,
//           isFiltering: event.isFiltering,
//           generalTaskList: generalTaskList,
//           appliedFilters: state.appliedFilters));
//     });
//     on<LoadMyJobs>((event, emit) async {
//       emit(MyJobsInitial());

//       final currentUserInfo = await _getCurrentUser();
//       List<Client>? clients = await getClients();
//       if (currentUserInfo.userKey.aggregateId!.isEmpty) {
//         emit(MyJobsError(message: 'User aggregateId is empty'));
//         return;
//       }
//       final Map<String, dynamic> payload = {
//         "fromDate": getyyyyMMdd(getFromDateForJobsApi()),
//         "toDate": getyyyyMMdd(getToDateForJobsApi()),
//         "statuses": ["Planned", "Active"],
//         "pageIndex": 0,
//         "contextUserId": currentUserInfo.userKey.aggregateId,
//       };

//       try {
//         final result = await apiTimecardClient.getJobs(requestPayload: payload);

//         emit(MyJobsLoaded(
//           jobs: result.jobs ?? [],
//           projects: result.projects ?? [],
//           clients: clients ?? [],
//           currentUserInfo: currentUserInfo,
//         ));
//       } catch (e) {
//         print('Error loading MyJobs data: $e');
//       }
//     });

//     on<LoadNotes>((event, emit) async {
//       final currentJobs = state.jobs;
//       final currentProjects = state.projects;
//       final currentClients = state.clients;
//       final currentExpandedTiles = state.expandedTiles;
//       final currentSearchQuery = state.searchQuery;
//       final currentIsClearSearchField = state.isClearSearchField;
//       final currentUserInfo = state.currentUserInfo;

//       if (event.jobId.isEmpty) {
//         print('empty job id');
//         return;
//       }

//       try {
//         final notesResult = await clipboardUsecase.getMyJobsNotes(event.jobId);
//         notesResult.fold(
//           (l) {
//             print('Failed to load notes: ${l.message}');
//           },
//           (r) {
//             print('Notes loaded successfully: ${r?.length ?? 0} notes');
//             emit(MyJobsLoaded(
//                 jobs: currentJobs,
//                 projects: currentProjects,
//                 clients: currentClients,
//                 expandedTiles: currentExpandedTiles,
//                 searchQuery: currentSearchQuery,
//                 isClearSearchField: currentIsClearSearchField,
//                 currentUserInfo: currentUserInfo,
//                 notes: r,
//                 sortType: state.sortType,
//                 appliedFilters: state.appliedFilters));
//           },
//         );
//       } catch (e) {
//         print('Error loading notes: $e');
//       }
//     });

//     on<AddJobNote>((event, emit) async {
//       final currentJobs = state.jobs;
//       final currentProjects = state.projects;
//       final currentClients = state.clients;
//       final currentExpandedTiles = state.expandedTiles;
//       final currentSearchQuery = state.searchQuery;
//       final currentIsClearSearchField = state.isClearSearchField;
//       final currentUserInfo = state.currentUserInfo;
//       final currentNotes = state.notes ?? [];

//       final noteResult = await clipboardUsecase.addMyJobsNote(event.payload);
//       noteResult.fold(
//         (l) {
//           print('Failed to add note: ${l.message}');
//         },
//         (r) {
//           emit(MyJobsLoaded(
//             jobs: currentJobs,
//             projects: currentProjects,
//             clients: currentClients,
//             expandedTiles: currentExpandedTiles,
//             searchQuery: currentSearchQuery,
//             sortType: state.sortType,
//             isClearSearchField: currentIsClearSearchField,
//             currentUserInfo: currentUserInfo,
//             notes: [...currentNotes, r],
//             appliedFilters: state.appliedFilters,
//           ));
//         },
//       );
//     });

//     on<EditJobNote>((event, emit) async {
//       final currentJobs = state.jobs;
//       final currentProjects = state.projects;
//       final currentClients = state.clients;
//       final currentExpandedTiles = state.expandedTiles;
//       final currentSearchQuery = state.searchQuery;
//       final currentIsClearSearchField = state.isClearSearchField;
//       final currentUserInfo = state.currentUserInfo;
//       final currentNotes = state.notes ?? [];

//       final note =
//           await clipboardUsecase.updateMyJobNote(event.noteId, event.payload);
//       note.fold(
//         (l) {
//           print('Failed to edit note: ${l.message}');
//         },
//         (r) {
//           final noteIndex =
//               currentNotes.indexWhere((note) => note.id == event.noteId);
//           final updatedNotes = List<NotesDTO>.from(currentNotes);
//           if (noteIndex >= 0) {
//             updatedNotes[noteIndex] = r;
//           }

//           emit(MyJobsLoaded(
//               jobs: currentJobs,
//               projects: currentProjects,
//               clients: currentClients,
//               expandedTiles: currentExpandedTiles,
//               searchQuery: currentSearchQuery,
//               isClearSearchField: currentIsClearSearchField,
//               currentUserInfo: currentUserInfo,
//               notes: updatedNotes,
//               sortType: state.sortType,
//               appliedFilters: state.appliedFilters));
//         },
//       );
//     });

//     on<DeleteJobNote>((event, emit) async {
//       final currentJobs = state.jobs;
//       final currentProjects = state.projects;
//       final currentClients = state.clients;
//       final currentExpandedTiles = state.expandedTiles;
//       final currentSearchQuery = state.searchQuery;
//       final currentIsClearSearchField = state.isClearSearchField;
//       final currentUserInfo = state.currentUserInfo;
//       final currentNotes = state.notes ?? [];

//       final note = await clipboardUsecase.deleteMyJobNote(event.noteId);
//       note.fold(
//         (l) {
//           print('Failed to delete note: ${l.message}');
//         },
//         (r) {
//           final updatedNotes =
//               currentNotes.where((note) => note.id != event.noteId).toList();

//           emit(MyJobsLoaded(
//             jobs: currentJobs,
//             projects: currentProjects,
//             clients: currentClients,
//             expandedTiles: currentExpandedTiles,
//             searchQuery: currentSearchQuery,
//             sortType: state.sortType,
//             isClearSearchField: currentIsClearSearchField,
//             currentUserInfo: currentUserInfo,
//             notes: updatedNotes,
//             appliedFilters: state.appliedFilters,
//           ));
//         },
//       );
//     });

//     on<ToggleJobExpansion>((event, emit) {
//       final newSet = Set<int>.from(state.expandedTiles);
//       if (event.expanded) {
//         newSet.add(event.index);
//       } else {
//         newSet.remove(event.index);
//       }

//       if (state is MyJobsLoaded) {
//         emit((state as MyJobsLoaded).copyWith(expandedTiles: newSet));
//       } else {
//         emit(MyJobsLoaded(
//           jobs: state.jobs,
//           projects: state.projects,
//           clients: state.clients,
//           searchQuery: state.searchQuery,
//           sortType: state.sortType,
//           expandedTiles: newSet,
//           currentUserInfo: state.currentUserInfo,
//           appliedFilters: state.appliedFilters,
//         ));
//       }
//     });

//     on<StartJobEvent>(
//       (event, emit) async {
//         final taskInfo = await _getGeneralTaskList();
//         final currentUserInfo = await _getCurrentUser();
//         final PlannerServiceGeneralTasklistDTO taskToAttributeProjectAndJob =
//             taskInfo;

//         final payload = {
//           "plannerKey": {
//             ...taskToAttributeProjectAndJob.anyBiz!.plannerKey!.toJson(),
//             'aggregateId':
//                 '${taskToAttributeProjectAndJob.plannerKey?.workKey?.aggregateId}_tasks',
//             'doctype': "PlannerKey",
//             'personalTime': false,
//             'plannerType': "System",
//             'userKey': null
//           },
//           "task": {
//             "assignee": currentUserInfo.userKey,
//             "templateTaskId": taskToAttributeProjectAndJob.anyBiz?.taskId ?? '',
//             "details": event.details,
//             "estimateUnit": event.estimateUnit,
//             "estimateValue": event.estimateValue,
//             "projectId": event.projectId,
//             "jobId": event.jobId,
//             'taskLocation': "Home",
//             'taskPriority': "Normal",
//             'dueDatetime': null
//           },
//         };

//         await clipboardUsecase
//             .startFromTab(
//                 '${taskToAttributeProjectAndJob.plannerKey?.workKey?.aggregateId}_tasks',
//                 payload)
//             .then(
//           (value) {
//             value.fold(
//               (l) => log('fail $l'),
//               (r) {
//                 emit(MyJobsRefreshTimecard(
//                   Timecard.fromJson(r['clockcard']),
//                   clients: state.clients,
//                   jobs: state.jobs,
//                   projects: state.projects,
//                   expandedTiles: state.expandedTiles,
//                   searchQuery: state.searchQuery,
//                   isClearSearchField: state.isClearSearchField,
//                   currentUserInfo: state.currentUserInfo,
//                   notes: state.notes,
//                   sortType: state.sortType,
//                   appliedFilters: state.appliedFilters,
//                 ));

//                 emit(MyJobsLoaded(
//                     jobs: state.jobs,
//                     projects: state.projects,
//                     clients: state.clients,
//                     expandedTiles: state.expandedTiles,
//                     currentUserInfo: state.currentUserInfo,
//                     searchQuery: state.searchQuery,
//                     sortType: state.sortType,
//                     isClearSearchField: state.isClearSearchField,
//                     notes: state.notes,
//                     appliedFilters: state.appliedFilters));
//               },
//             );
//           },
//         );
//       },
//     );
//   }

//   Future<CurrentUserInfo> _getCurrentUser() async {
//     final currentUserInfoResult = await authUsecase.getCurrentUserInfo();
//     return currentUserInfoResult.fold(
//       (failure) => throw Exception(
//           'Failed to get current user info: ${failure.message}'),
//       (currentUserInfo) => currentUserInfo,
//     );
//   }

//   Future<Taskboard> _getTaskData() async {
//     final currentTaskInfoResult = await clipboardUsecase.loadTaskboardNew();
//     return currentTaskInfoResult.fold(
//       (failure) => throw Exception(
//           'Failed to get current user info: ${failure.message}'),
//       (currentTaskInfo) => Taskboard.fromJson(currentTaskInfo['taskboard']),
//     );
//   }

//   Future<PlannerServiceGeneralTasklistDTO> _getGeneralTaskList() async {
//     final result = await clipboardUsecase.getGeneralTaskList();
//     return result.fold(
//       (failure) => throw Exception(
//           'Failed to get general task list: ${failure.message}'),
//       (generalTaskList) => generalTaskList,
//     );
//   }

//   Future<List<Client>?> getClients() async {
//     return await clipboardUsecase.getClients().then((value) {
//       return value.fold((l) => null, (r) {
//         return r;
//       });
//     });
//   }

//   Future<List<Deliverable>?> getDeliverables(
//       {required String projectId,
//       required bool includeCount,
//       required bool includeAll}) async {
//     return await clipboardUsecase
//         .getDeliverables(projectId, includeCount, includeAll)
//         .then((value) {
//       return value.fold((l) => null, (r) {
//         return r;
//       });
//     });
//   }

//   Future<Job?> addNewJob({required JobPayloadDTO jobPayload}) async {
//     return projectsUsecase.addNewJob(jobPayload).then((value) {
//       return value.fold((l) => null, (r) {
//         return r;
//       });
//     });
//   }

//   Future<Job?> addJob({required Map<String, dynamic> payload}) async {
//     return projectsUsecase
//         .addJob(background: false, payload: payload)
//         .then((value) {
//       return value.fold((l) => null, (r) {
//         return r;
//       });
//     });
//   }

//   Future<List<Job>?> updateJob(
//       {required String jobId, required Map<String, dynamic> payload}) async {
//     return projectsUsecase
//         .updateJob(jobId: jobId, payload: payload)
//         .then((value) {
//       return value.fold((l) => null, (r) {
//         return r;
//       });
//     });
//   }

//   Future<TaskStatDTO?> getJobTaskStat({required String jobId}) async {
//     return projectsUsecase.getJobTaskStat(jobId: jobId).then((value) {
//       return value.fold((l) => null, (r) => r);
//     });
//   }

//   Future<TaskDTO?> addTaskToJob(
//       {required String plannerKeyAggregateId,
//       required Map<String, dynamic> payload}) async {
//     return projectsUsecase
//         .addTaskToJob(
//             plannerKeyAggregateId: plannerKeyAggregateId, payload: payload)
//         .then((value) => value.fold((l) => null, (r) => r));
//   }
// }
