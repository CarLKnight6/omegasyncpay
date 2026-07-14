// import 'package:coamplifi_pro/data/api/api_client/api_timecard_client_type.dart';
// import 'package:coamplifi_pro/data/dto/job_payload_dto.dart';
// import 'package:coamplifi_pro/di.dart';
// import 'package:coamplifi_pro/domain/auth/auth_usecase_type.dart';
// import 'package:coamplifi_pro/domain/clipboard/clipboard_repository_type.dart';
// import 'package:coamplifi_pro/domain/clipboard/clipboard_usecase_type.dart';
// import 'package:coamplifi_pro/domain/projects/projects_usecase_type.dart';
// import 'dart:math';
// import 'package:coamplifi_pro/data/dto/projects_dto.dart';
// import 'package:coamplifi_pro/domain/auth/user_key.dart';
// import 'package:coamplifi_pro/model/client.dart';
// import 'package:coamplifi_pro/model/deliverable.dart';
// import 'package:coamplifi_pro/model/job.dart';
// import 'package:coamplifi_pro/model/work_key.dart';
// import 'package:coamplifi_pro/presentation/auth/loading_page.dart';
// import 'package:coamplifi_pro/presentation/clipboard/utils/const.dart';
// import 'package:coamplifi_pro/presentation/my_jobs/bloc/my_jobs_bloc.dart';
// import 'package:coamplifi_pro/presentation/my_jobs/my_jobs_utils.dart';
// import 'package:coamplifi_pro/presentation/my_jobs/widgets/job_form.dart';
// import 'package:coamplifi_pro/presentation/my_jobs/widgets/add_job_select_project.dart';
// import 'package:coamplifi_pro/presentation/my_jobs/widgets/add_my_jobs_dialog.dart';
// import 'package:coamplifi_pro/presentation/my_jobs/widgets/filter_my_jobs_dialog.dart';
// import 'package:coamplifi_pro/presentation/my_jobs/widgets/sort_my_jobs_dialog.dart';
// import 'package:coamplifi_pro/presentation/my_jobs/widgets/start_my_jobs_dialog.dart';
// import 'package:coamplifi_pro/presentation/theme/constants.dart';
// import 'package:coamplifi_pro/presentation/timeclock/bloc/timeclock_bloc.dart';
// import 'package:coamplifi_pro/presentation/widgets/bottom_sheet.dart';
// import 'package:coamplifi_pro/presentation/widgets/cs_chip.dart';
// import 'package:coamplifi_pro/presentation/widgets/expanded_save_button.dart';
// import 'package:coamplifi_pro/presentation/widgets/standard_text_form_field.dart';
// import 'package:coamplifi_pro/presentation/widgets/text_widget.dart';
// import 'package:coamplifi_pro/presentation/widgets/textformfield_widget.dart';
// import 'package:coamplifi_pro/utils/constants.dart';
// import 'package:coamplifi_pro/utils/function/text_formatting.dart';
// import 'package:coamplifi_pro/utils/function/time_fn.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// Color getRandomColor() {
//   final _random = Random();
//   return Colors.primaries[_random.nextInt(Colors.primaries.length)];
// }

// _renderProjectContainer(
//     {required ProjectsListDTO project,
//     required List<Job> jobs,
//     required String selectedJobId,
//     void Function(Job job, ProjectsListDTO project)? onTap}) {
//   String initial =
//       project.workKey?.title != null ? project.workKey!.title![0] : '';

//   return Container(
//     padding: EdgeInsets.all(12),
//     decoration: BoxDecoration(
//       border: Border.all(color: StyleDictionaryColor.systemColorsOtherStroke),
//       borderRadius: BorderRadius.circular(10),
//     ),
//     child: Column(
//       children: [
//         Row(
//           children: [
//             // Project initial
//             SizedBox(
//               width: 25.0,
//               height: 25.0,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(6), // 0 = square
//                 child: Container(
//                   color: getRandomColor(),
//                   alignment: Alignment.center,
//                   child: TextWidget(
//                     text: initial,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: StyleDictionaryColor.systemColorsPrimaryContrasttext,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 10),
//             TextWidget(
//               text: project.workKey?.title ?? '',
//               fontSize: 14,
//               fontWeight: FontWeight.w500,
//               color: StyleDictionaryColor.systemColorsTextDisabled,
//             ),
//           ],
//         ),
//         const SizedBox(height: 8),
//         if (jobs.isNotEmpty) ...[
//           for (int i = 0; i < jobs.length; i++) ...[
//             ListTile(
//               selected: selectedJobId == jobs[i].id,
//               title: TextWidget(
//                 text: jobs[i].name ?? '',
//                 fontSize: 15,
//               ),
//               trailing: IconButton(
//                 onPressed: () {},
//                 icon: Icon(Icons.more_vert, color: Colors.black),
//                 padding: EdgeInsets.zero,
//                 constraints: BoxConstraints(),
//               ),
//               onTap: () => onTap?.call(jobs[i], project),
//             )
//           ],
//         ],
//       ],
//     ),
//   );
// }

// /// Abstract base class for items displayed in the jobs list.
// abstract class DisplayItem {}

// /// Represents a header item in the project list, e.g., "No Client" or a client name.
// class HeaderItem extends DisplayItem {
//   final String title;
//   final bool hasClient;

//   HeaderItem(this.title, this.hasClient);
// }

// /// Represents a project group header in the jobs list.
// class ProjectItem extends DisplayItem {
//   final String projectTitle;
//   final ProjectsListDTO project;
//   final List<Job> jobs;
//   ProjectItem(this.projectTitle, this.project, this.jobs);
// }

// class JobList extends StatefulWidget {
//   final List<ProjectsListDTO> projects;
//   final List<Job> jobs;
//   final List<Client> clients;
//   final bool isCalendar;
//   final String? initialProjectId;
//   final String? initialJobId;
//   final UserKey currentUser;

//   /// When provided, Add Job uses callback (stays on JobList for selection).
//   /// When null, pops with payload (for MyJobsPage flow).
//   final void Function(Map<String, dynamic> payload)? onJobCreated;

//   const JobList({
//     super.key,
//     required this.projects,
//     required this.jobs,
//     required this.clients,
//     required this.isCalendar,
//     this.initialProjectId,
//     this.initialJobId,
//     required this.currentUser,
//     this.onJobCreated,
//   });

//   @override
//   State<JobList> createState() => _JobListState();
// }

// class _JobListState extends State<JobList> {
//   String _selectedJobId = '';
//   WorkKey? _selectedJobAssociatedProjectWorkKey;
//   List<DisplayItem> _displayItems = [];
//   final TextEditingController _searchController = TextEditingController();
//   String _searchQuery = '';

//   @override
//   void initState() {
//     super.initState();
//     _initializeInitialJob();
//     _buildDisplayItems();
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   void didUpdateWidget(covariant JobList oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     // Refresh the displayed projects/jobs when bloc state updates (e.g. after Add Job).
//     if (oldWidget.projects != widget.projects ||
//         oldWidget.jobs != widget.jobs ||
//         oldWidget.clients != widget.clients) {
//       _buildDisplayItems();
//     }
//   }

//   void _initializeInitialJob() {
//     if (widget.initialJobId != null) {
//       _selectedJobId = widget.initialJobId ?? '';
//     }
//   }

//   /// Checks if a project has any associated jobs.
//   ///
//   /// Uses different matching logic based on the context:
//   /// - When `isCalendar` is true: matches jobs by `projectId` field
//   /// - When `isCalendar` is false: matches jobs by `workKey.aggregateId` field
//   ///
//   /// Returns true if at least one job is associated with the given project.
//   bool _checkProjectHasJobs(ProjectsListDTO project) {
//     return widget.jobs.any((job) {
//       return job.workKey?.aggregateId == project.workKey?.aggregateId;
//     });
//   }

//   void _buildDisplayItems() {
//     _displayItems.clear();

//     // Filter projects: status must be "Planned" or "Active" and endDate must not have passed
//     final now = DateTime.now();
//     final filteredProjects = widget.projects.where((project) {
//       // Check status
//       final status = ProjectStatusExtension.fromString(project.status);
//       if (status != ProjectStatus.Planned && status != ProjectStatus.Active) {
//         return false;
//       }

//       // Check endDate
//       if (project.endDate != null && project.endDate!.isNotEmpty) {
//         try {
//           final endDate = DateTime.parse(project.endDate!);
//           if (endDate.isBefore(now)) {
//             return false;
//           }
//         } catch (e) {
//           return false;
//         }
//       }

//       // Check if project has jobs
//       if (!_checkProjectHasJobs(project)) {
//         return false;
//       }

//       return true;
//     });

//     // Apply search filter when query is not empty
//     final query = _searchQuery.trim().toLowerCase();
//     final searchFilteredProjects = query.isEmpty
//         ? filteredProjects.toList()
//         : filteredProjects.where((project) {
//             final projectTitle = project.workKey?.title?.toLowerCase() ?? '';
//             final clientName = widget.clients
//                     .firstWhere((client) => client.id == project.clientId,
//                         orElse: () => Client(name: ''))
//                     .name
//                     ?.toLowerCase() ??
//                 '';

//             final projectMatches =
//                 projectTitle.contains(query) || clientName.contains(query);

//             final projectJobs = widget.jobs.where((job) =>
//                 job.workKey?.aggregateId == project.workKey?.aggregateId);
//             final jobMatches = projectJobs
//                 .any((job) => job.name?.toLowerCase().contains(query) ?? false);

//             return projectMatches || jobMatches;
//           }).toList();

//     final projectsWithNoClient = searchFilteredProjects
//         .where((element) => element.clientId == null)
//         .toList();
//     if (projectsWithNoClient.isNotEmpty) {
//       _displayItems.add(HeaderItem('No Client', false));
//       for (ProjectsListDTO project in projectsWithNoClient) {
//         // List the jobs included on the project by matching id
//         List<Job> jobs = widget.jobs.where((job) {
//           String? projectId = job.workKey?.aggregateId;
//           return projectId == project.workKey?.aggregateId;
//         }).toList();
//         // Filter jobs by search query when searching
//         if (query.isNotEmpty) {
//           jobs = jobs
//               .where((job) => job.name?.toLowerCase().contains(query) ?? false)
//               .toList();
//         }
//         _displayItems
//             .add(ProjectItem(project.workKey?.title ?? '', project, jobs));
//       }
//     }

//     // Build a list of unique clients that have at least one matching project
//     // in `searchFilteredProjects` (project.clientId != null and equals client.id).
//     final clientsWithProject = widget.clients.where((client) {
//       return searchFilteredProjects.any(
//         (project) => project.clientId != null && project.clientId == client.id,
//       );
//     }).toList();

//     if (clientsWithProject.isNotEmpty) {
//       for (Client client in clientsWithProject) {
//         _displayItems.add(HeaderItem(client.name ?? '', true));

//         List<ProjectsListDTO> projects = searchFilteredProjects
//             .where((project) => project.clientId == client.id)
//             .toList();

//         for (ProjectsListDTO project in projects) {
//           // List the jobs included on the project by matching id
//           List<Job> jobs = widget.jobs.where((job) {
//             String? projectId = job.workKey?.aggregateId;
//             return projectId == project.workKey?.aggregateId;
//           }).toList();
//           // Filter jobs by search query when searching
//           if (query.isNotEmpty) {
//             jobs = jobs
//                 .where(
//                     (job) => job.name?.toLowerCase().contains(query) ?? false)
//                 .toList();
//           }
//           _displayItems
//               .add(ProjectItem(project.workKey?.title ?? '', project, jobs));
//         }
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: StyleDictionaryColor.systemColorsBackgroundPaper,
//       body: Column(
//         children: [
//           Container(
//             width: double.infinity,
//             padding: EdgeInsets.zero,
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               spacing: 8,
//               children: [
//                 Expanded(
//                   child: StandardTextFormField(
//                     controller: _searchController,
//                     hintText: toSentenceCase('job_name'.tr()),
//                     suffixIcon: _searchController.text.trim().isEmpty
//                         ? null
//                         : GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 _searchController.clear();
//                                 _searchQuery = '';
//                                 _buildDisplayItems();
//                               });
//                               FocusScope.of(context).unfocus();
//                             },
//                             child: Icon(Icons.close),
//                           ),
//                     onChanged: (value) {
//                       setState(() {
//                         _searchQuery = value;
//                         _buildDisplayItems();
//                       });
//                     },
//                   ),
//                 ),
//                 Row(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       clipBehavior: Clip.antiAlias,
//                       decoration: ShapeDecoration(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(4)),
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         spacing: 8,
//                         children: [
//                           Row(
//                             mainAxisSize: MainAxisSize.min,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             spacing: 8,
//                             children: [
//                               Container(
//                                 width: 24,
//                                 height: 24,
//                                 clipBehavior: Clip.antiAlias,
//                                 decoration: BoxDecoration(),
//                                 child: Stack(),
//                               ),
//                             ],
//                           ),
//                           TextButton.icon(
//                               icon: Icon(Icons.add,
//                                   color: StyleDictionaryColor
//                                       .systemColorsNeutralMain),
//                               style: TextButton.styleFrom(
//                                   overlayColor: StyleDictionaryColor
//                                       .systemColorsNeutralBackground),
//                               onPressed: () async {
//                                 await CustomBottomSheet.show<
//                                     Map<String, dynamic>>(
//                                   context: context,
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.7,
//                                   title: 'add_job'.tr(),
//                                   hasLeadingIcon: false,
//                                   hasSecondaryHeaderWidget: true,
//                                   secondaryHeaderWidget:
//                                       (secondaryHeaderWidgetContext) {
//                                     final neutralColor = Theme.of(context)
//                                         .colorScheme
//                                         .onSurfaceVariant;

//                                     return IconButton(
//                                       onPressed: () => Navigator.of(context,
//                                               rootNavigator: true)
//                                           .pop(),
//                                       icon: Icon(Icons.close,
//                                           color: neutralColor),
//                                     );
//                                   },
//                                   child: Navigator(
//                                     clipBehavior: Clip.none,
//                                     onGenerateRoute: (settings) {
//                                       return MaterialPageRoute(
//                                         builder: (context) =>
//                                             AddJobSelectProject(
//                                           projects: widget.projects,
//                                           jobs: widget.jobs,
//                                           clients: widget.clients,
//                                           isCalendar: widget.isCalendar,
//                                           currentUser: widget.currentUser,
//                                           onJobCreated: widget.onJobCreated,
//                                         ),
//                                         settings: settings,
//                                       );
//                                     },
//                                   ),
//                                 );
//                               },
//                               label: TextWidget(
//                                 text: 'add_job'.tr(),
//                                 fontSize: 14,
//                                 color: StyleDictionaryColor
//                                     .systemColorsNeutralMain,
//                               )),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: _displayItems.any((item) => item is ProjectItem)
//                 ? ListView.builder(
//                     itemCount: _displayItems.length,
//                     itemBuilder: (context, index) {
//                       final item = _displayItems[index];
//                       if (item is HeaderItem) {
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(height: 10),
//                             TextWidget(
//                               text: item.title,
//                               textStyle: !item.hasClient
//                                   ? Theme.of(context)
//                                       .textTheme
//                                       .labelLarge
//                                       ?.copyWith(fontStyle: FontStyle.italic)
//                                   : null,
//                             ),
//                             SizedBox(height: 10),
//                           ],
//                         );
//                       } else if (item is ProjectItem) {
//                         final project = item.project;
//                         final jobs = item.jobs;

//                         return _renderProjectContainer(
//                           project: project,
//                           jobs: jobs,
//                           selectedJobId: _selectedJobId,
//                           onTap: (job, project) {
//                             setState(() {
//                               _selectedJobId = job.id ?? '';
//                               _selectedJobAssociatedProjectWorkKey =
//                                   project.workKey;
//                             });
//                           },
//                         );
//                       }
//                       return const SizedBox.shrink(); // Should not happen
//                     },
//                   )
//                 : SizedBox.expand(
//                     child: Center(
//                       child: TextWidget(
//                         text: _searchQuery.trim().isNotEmpty
//                             ? 'no_jobs_match_search'.tr()
//                             : 'no_jobs_found'.tr(),
//                         fontWeight: FontWeight.w500,
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ),
//           ),
//           Padding(
//             padding: EdgeInsets.zero,
//             child: ExpandedSaveButton(
//               onSavePressed: _selectedJobId.trim().isNotEmpty
//                   ? () {
//                       Job? job = widget.jobs
//                           .firstWhere((job) => job.id == _selectedJobId);
//                       if (job.workKey?.aggregateId == null) {
//                         job.workKey = _selectedJobAssociatedProjectWorkKey;
//                       }
//                       Navigator.of(context, rootNavigator: true).pop(job);
//                     }
//                   : null,
//               text: 'confirm'.tr(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MyJobsPage extends StatefulWidget {
//   const MyJobsPage({super.key});

//   @override
//   State<MyJobsPage> createState() => _MyJobsPageState();
// }

// class _MyJobsPageState extends State<MyJobsPage> {
//   final TextEditingController _searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();

//     _searchController.addListener(() {
//       if (mounted) setState(() {});
//     });
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => MyJobsBloc(
//           apiTimecardClient: getIt<APITimeCardClientType>(),
//           clipboardUsecase: getIt<ClipboardUsecaseType>(),
//           authUsecase: getIt<AuthUsecaseType>(),
//           projectsUsecase: getIt<ProjectsUsecaseType>(),
//           clipboardRepository: getIt<ClipboardRepositoryType>())
//         ..add(LoadMyJobs()),
//       child: BlocListener<MyJobsBloc, MyJobsState>(
//         listener: (context, state) async {
//           if (state is MyJobsRefreshTimecard) {
//             context
//                 .read<TimeclockBloc>()
//                 .add(TestTimeclock(timecard: state.timecard));
//           } else if (state is AddNewJobSucess) {
//             context.read<MyJobsBloc>().add(LoadMyJobs());
//           } else if (state.isClearSearchField) {
//             _searchController.clear();
//           } else if (state is SelectedProjectLoaded &&
//               state.isFiltering != true) {
//             ProjectsListDTO project = state.projectDTO ?? ProjectsListDTO();

//             String projectName = project.workKey?.title?.isNotEmpty == true
//                 ? project.workKey!.title!
//                 : '';
//             String projectNameInitial =
//                 projectName.isNotEmpty ? projectName[0] : '';
//             Client? client;
//             if (project.clientId != null) {
//               try {
//                 client =
//                     state.clients.firstWhere((c) => c.id == project.clientId);
//               } catch (_) {
//                 client = null;
//               }
//             } else {
//               client = null;
//             }

//             Job? job = state.jobData;

//             await CustomBottomSheet.show<Map<String, dynamic>>(
//               context: context,
//               title: 'add_job'.tr(),
//               height: MediaQuery.of(context).size.height * 0.7,
//               useCustomTitle: true,
//               centerTitle: false,
//               hasLeadingIcon: false,
//               hasSecondaryHeaderWidget: true,
//               secondaryHeaderWidget: (secondaryHeaderWidgetContext) {
//                 Color buttonColor =
//                     StyleDictionaryColor.systemColorsNeutralMain;

//                 return Row(
//                   children: [
//                     IconButton(
//                       onPressed: () =>
//                           Navigator.of(context, rootNavigator: true).pop(),
//                       icon: Icon(Icons.close, color: buttonColor),
//                     ),
//                   ],
//                 );
//               },
//               customTitleWidget: TextWidget(
//                 text: projectName,
//                 fontSize: 20,
//                 fontWeight: FontWeight.w600,
//                 textAlign: TextAlign.left,
//               ),
//               child: Navigator(
//                 onGenerateRoute: (settings) {
//                   return MaterialPageRoute(
//                     builder: (routeContext) => JobForm(
//                       project: project,
//                       client: client,
//                       job: job,
//                       isAddingNewJob: state.isAddingNewJob,
//                       currentUser: state.currentUserInfo.userKey,
//                       deliverables: state.deliverableData,
//                       plannerKey: state.generalTaskList.anyBiz?.plannerKey,
//                       templateTaskId: state.generalTaskList.anyBiz?.taskId,
//                       createBtnOnTap: (payload) {
//                         bool isAdd = state.isAddingNewJob;
//                         if (isAdd) {
//                           context
//                               .read<MyJobsBloc>()
//                               .add(AddJob(payload: payload));
//                         } else {
//                           context.read<MyJobsBloc>().add(
//                               UpdateJob(payload: payload, jobid: job.id ?? ''));
//                         }
//                       },
//                     ),
//                     settings: settings,
//                   );
//                 },
//               ),
//             );
//           }
//         },
//         child: BlocBuilder<MyJobsBloc, MyJobsState>(
//           builder: (context, state) {
//             if (state is MyJobsInitial) {
//               return LoadingPage();
//             }

//             final projectsWithJobs = state.projects.where((project) {
//               final projectJobs = state.jobs
//                   .where((job) =>
//                       job.workKey!.aggregateId == project.workKey!.aggregateId)
//                   .toList();
//               return projectJobs.isNotEmpty;
//             }).toList();

//             final filteredProjects = state.searchQuery.isEmpty
//                 ? projectsWithJobs
//                 : projectsWithJobs.where((project) {
//                     final projectTitle =
//                         project.workKey?.title?.toLowerCase() ?? '';
//                     final clientName = state.clients
//                             .firstWhere(
//                                 (client) => client.id == project.clientId,
//                                 orElse: () => Client(name: ''))
//                             .name
//                             ?.toLowerCase() ??
//                         '';
//                     final query = state.searchQuery.toLowerCase();

//                     // Check if project matches
//                     final projectMatches = projectTitle.contains(query) ||
//                         clientName.contains(query);

//                     // Check if any job under this project matches
//                     final projectJobs = state.jobs.where((job) =>
//                         job.workKey?.aggregateId ==
//                         project.workKey?.aggregateId);
//                     final jobMatches = projectJobs.any((job) =>
//                         job.name?.toLowerCase().contains(query) ?? false);

//                     return projectMatches || jobMatches;
//                   }).toList();

//             return Scaffold(
//               body: Column(
//                 children: [
//                   // SEARCH BAR
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           flex: 7,
//                           child: TextFormFieldWidget(
//                               suffixIcon: _searchController.text.trim().isEmpty
//                                   ? null
//                                   : GestureDetector(
//                                       onTap: () {
//                                         _searchController.clear();
//                                         context
//                                             .read<MyJobsBloc>()
//                                             .add(SearchMyJobs(''));
//                                         FocusScope.of(context).unfocus();
//                                       },
//                                       child: Icon(Icons.close)),
//                               height: 45,
//                               label: 'Search',
//                               textFieldController: _searchController,
//                               onChanged: (value) {
//                                 context
//                                     .read<MyJobsBloc>()
//                                     .add(SearchMyJobs(value));
//                               }),
//                         ),
//                         const SizedBox(width: 8),
//                         Expanded(
//                           flex: 3,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               GestureDetector(
//                                   onTap: () async {
//                                     final myJobsBloc =
//                                         context.read<MyJobsBloc>();
//                                     CustomBottomSheet.show(
//                                       context: context,
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                               0.7,
//                                       title: 'all_filters'.tr(),
//                                       hasSecondaryHeaderWidget: false,
//                                       child: Navigator(
//                                         clipBehavior: Clip.none,
//                                         onGenerateRoute: (settings) {
//                                           return MaterialPageRoute(
//                                               builder:
//                                                   (materialPageRouteContext) =>
//                                                       BlocBuilder<MyJobsBloc,
//                                                           MyJobsState>(
//                                                         bloc: myJobsBloc,
//                                                         builder:
//                                                             (_, blocState) {
//                                                           final deliverablesReady =
//                                                               blocState
//                                                                   is SelectedProjectLoaded;
//                                                           final filterDeliverables =
//                                                               deliverablesReady
//                                                                   ? blocState
//                                                                       .deliverableData
//                                                                   : <Deliverable>[];
//                                                           return MyJobsFilter(
//                                                             dialogContext:
//                                                                 context,
//                                                             clients:
//                                                                 state.clients,
//                                                             projects:
//                                                                 state.projects,
//                                                             searchController:
//                                                                 _searchController,
//                                                             isMyJobs: true,
//                                                             appliedFilters:
//                                                                 blocState
//                                                                     .appliedFilters,
//                                                             filterDeliverables:
//                                                                 filterDeliverables,
//                                                             filterDeliverablesReady:
//                                                                 deliverablesReady,
//                                                             onFilterProjectSelected:
//                                                                 (project) {
//                                                               myJobsBloc.add(
//                                                                   ClearProjectSelection());
//                                                               myJobsBloc.add(
//                                                                 SelectProject(
//                                                                     project
//                                                                         .workKey!
//                                                                         .aggregateId!,
//                                                                     0,
//                                                                     0,
//                                                                     true,
//                                                                     Job(),
//                                                                     projectDTO:
//                                                                         project,
//                                                                     isAddingNewJob:
//                                                                         true,
//                                                                     isFiltering:
//                                                                         true),
//                                                               );
//                                                             },
//                                                             onApplyFilters:
//                                                                 (selectedFilters) {
//                                                               myJobsBloc.add(
//                                                                 FilterMyJobs(
//                                                                     selectedMembership:
//                                                                         selectedFilters[
//                                                                             'selectedMembership'],
//                                                                     projectId:
//                                                                         selectedFilters[
//                                                                             'projectId'],
//                                                                     statusFilterList:
//                                                                         selectedFilters[
//                                                                             'statusFilterList'],
//                                                                     priorityFilterList:
//                                                                         selectedFilters[
//                                                                             'priorityFilterList'],
//                                                                     accountId:
//                                                                         selectedFilters[
//                                                                             'accountId'],
//                                                                     clientId:
//                                                                         selectedFilters[
//                                                                             'clientId'],
//                                                                     dateRange:
//                                                                         selectedFilters[
//                                                                             'dateRange'],
//                                                                     deliverableId:
//                                                                         selectedFilters[
//                                                                             'deliverableId']),
//                                                               );
//                                                             },
//                                                           );
//                                                         },
//                                                       ),
//                                               settings: settings);
//                                         },
//                                       ),
//                                     );
//                                   },
//                                   child: Icon(Icons.filter_alt)),
//                               GestureDetector(
//                                 onTap: () {
//                                   showSortMyJobsDialog(context, state.sortType,
//                                       (sortType) {
//                                     context
//                                         .read<MyJobsBloc>()
//                                         .add(SortMyJobs(sortType: sortType));
//                                   });
//                                 },
//                                 child: Icon(Icons.sort),
//                               )
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   // MAIN JOBS LIST
//                   Expanded(
//                     child: filteredProjects.isEmpty
//                         ? Center(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 TextWidget(
//                                   text: 'No Project Found',
//                                   fontSize: 16,
//                                   color: Colors.grey,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ],
//                             ),
//                           )
//                         : ListView.separated(
//                             padding: EdgeInsets.zero,
//                             separatorBuilder: (_, __) => const Divider(
//                               height: 1,
//                               endIndent: 0,
//                               indent: 0,
//                               thickness: 0.8,
//                               color: Colors.grey,
//                             ),
//                             itemCount: filteredProjects.length,
//                             itemBuilder: (context, index) {
//                               final project = filteredProjects[index];
//                               final originalIndex =
//                                   state.projects.indexOf(project);
//                               final isExpanded =
//                                   state.expandedTiles.contains(originalIndex);
//                               final clientName = state.clients
//                                       .firstWhere(
//                                           (client) =>
//                                               client.id == project.clientId,
//                                           orElse: () => Client(name: ''))
//                                       .name ??
//                                   '';

//                               final projectJobs = state.jobs
//                                   .where((job) =>
//                                       job.workKey!.aggregateId ==
//                                       project.workKey!.aggregateId)
//                                   .toList();

//                               // Filter jobs if searching
//                               final displayJobs = state.searchQuery.isEmpty
//                                   ? sortJobs(projectJobs, state.sortType)
//                                   : sortJobs(
//                                       projectJobs
//                                           .where((job) =>
//                                               job.name?.toLowerCase().contains(
//                                                   state.searchQuery
//                                                       .toLowerCase()) ??
//                                               false)
//                                           .toList(),
//                                       state.sortType);

//                               return Card(
//                                 elevation: 0,
//                                 margin: EdgeInsets.zero,
//                                 shape: const RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.zero,
//                                 ),
//                                 child: ExpansionTile(
//                                   controlAffinity:
//                                       ListTileControlAffinity.trailing,
//                                   collapsedTextColor:
//                                       Theme.of(context).colorScheme.onSurface,
//                                   textColor:
//                                       Theme.of(context).colorScheme.onSurface,
//                                   collapsedIconColor:
//                                       Theme.of(context).colorScheme.onSurface,
//                                   iconColor:
//                                       Theme.of(context).colorScheme.onSurface,
//                                   onExpansionChanged: (value) {
//                                     context.read<MyJobsBloc>().add(
//                                         ToggleJobExpansion(
//                                             originalIndex, value));
//                                   },
//                                   trailing:
//                                       project.clientId.toString().isNotEmpty
//                                           ? SizedBox(
//                                               width: MediaQuery.of(context)
//                                                       .size
//                                                       .width *
//                                                   0.31,
//                                               child: TextWidget(
//                                                 text: clientName,
//                                                 fontSize: 13,
//                                                 color: Colors.grey,
//                                                 fontWeight: FontWeight.w600,
//                                                 maxLines: 1,
//                                                 overflow: TextOverflow.ellipsis,
//                                                 textAlign: TextAlign.center,
//                                               ),
//                                             )
//                                           : const SizedBox.shrink(),
//                                   tilePadding: const EdgeInsets.symmetric(
//                                       horizontal: 12, vertical: 4),
//                                   title: Row(
//                                     children: [
//                                       AnimatedRotation(
//                                         turns: isExpanded ? 0.25 : 0.0,
//                                         duration:
//                                             const Duration(milliseconds: 200),
//                                         child: const Icon(
//                                             Icons.keyboard_arrow_right),
//                                       ),
//                                       const SizedBox(width: 4),
//                                       Expanded(
//                                         child: TextWidget(
//                                           maxLines: 1,
//                                           text: project.workKey?.title ?? '',
//                                           fontWeight: FontWeight.w500,
//                                           fontSize: 16,
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   children: [
//                                     if (displayJobs.isEmpty &&
//                                         state.searchQuery.isNotEmpty)
//                                       Padding(
//                                         padding: const EdgeInsets.all(16.0),
//                                         child: TextWidget(
//                                           text: 'No matching jobs',
//                                           fontSize: 14,
//                                           color: Colors.grey,
//                                           textAlign: TextAlign.center,
//                                         ),
//                                       )
//                                     else
//                                       ListView.separated(
//                                         padding: EdgeInsets.zero,
//                                         separatorBuilder: (_, __) =>
//                                             const Divider(
//                                           height: 1,
//                                           thickness: 0.8,
//                                           indent: 0,
//                                           endIndent: 0,
//                                           color: Colors.grey,
//                                         ),
//                                         shrinkWrap: true,
//                                         physics:
//                                             const NeverScrollableScrollPhysics(),
//                                         itemCount: displayJobs.length,
//                                         itemBuilder: (context, jobIndex) {
//                                           final job = displayJobs[jobIndex];

//                                           final isJobOwner =
//                                               job.assignee?.aggregateId ==
//                                                   state.currentUserInfo?.userKey
//                                                       .aggregateId;
//                                           final isProjectOwner = project.workKey
//                                                   ?.creator?.aggregateId ==
//                                               state.currentUserInfo?.userKey
//                                                   .aggregateId;

//                                           return Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                                 horizontal: 23),
//                                             child: ListTile(
//                                               onTap: () {
//                                                 context.read<MyJobsBloc>().add(
//                                                     ClearProjectSelection());

//                                                 context.read<MyJobsBloc>().add(
//                                                       SelectProject(
//                                                         project.workKey!
//                                                             .aggregateId!,
//                                                         index,
//                                                         jobIndex,
//                                                         isJobEditable(
//                                                             jobStatus: job
//                                                                     .status ??
//                                                                 '',
//                                                             isExpired: !ignoreTimeComponentsforDateComparisonExpiration(
//                                                                 job
//                                                                     .targetStartDate,
//                                                                 job
//                                                                     .targetEndDate),
//                                                             projectStatus:
//                                                                 project.status ??
//                                                                     '',
//                                                             isJobOwner:
//                                                                 isJobOwner,
//                                                             isProjectOwner:
//                                                                 isProjectOwner),
//                                                         job,
//                                                         projectDTO: project,
//                                                       ),
//                                                     );
//                                               },
//                                               title: Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   TextWidget(
//                                                     text: job.name ?? '',
//                                                     maxLines: 1,
//                                                     overflow:
//                                                         TextOverflow.ellipsis,
//                                                     fontSize: 15,
//                                                   ),
//                                                   SizedBox(
//                                                     height: 8,
//                                                   ),
//                                                   Row(
//                                                     children: [
//                                                       CsChip(
//                                                         chipColor: getJobStatus(
//                                                                 job.status ??
//                                                                     '',
//                                                                 !ignoreTimeComponentsforDateComparisonExpiration(
//                                                                     job
//                                                                         .targetStartDate,
//                                                                     job
//                                                                         .targetEndDate))
//                                                             .withValues(
//                                                                 alpha: 0.1),
//                                                         labelColor: getJobStatus(
//                                                             job.status ?? '',
//                                                             !ignoreTimeComponentsforDateComparisonExpiration(
//                                                                 job.targetStartDate,
//                                                                 job.targetEndDate)),
//                                                         label:
//                                                             getJobStatusUiValue(
//                                                                 job.status ??
//                                                                     ""),
//                                                         shrinkWrap: true,
//                                                       ),
//                                                       SizedBox(width: 8),
//                                                       Icon(
//                                                         priorityFilter
//                                                             .firstWhere(
//                                                               (item) =>
//                                                                   item.value ==
//                                                                   job.priority,
//                                                               orElse: () =>
//                                                                   priorityFilter[
//                                                                       2],
//                                                             )
//                                                             .icon,
//                                                         color: priorityFilter
//                                                             .firstWhere(
//                                                               (item) =>
//                                                                   item.value ==
//                                                                   job.priority,
//                                                               orElse: () =>
//                                                                   priorityFilter[
//                                                                       2],
//                                                             )
//                                                             .color,
//                                                         size: 25,
//                                                         weight: 400,
//                                                         grade: 0,
//                                                         opticalSize: 48,
//                                                         fill: 0,
//                                                       )
//                                                     ],
//                                                   ),
//                                                 ],
//                                               ),
//                                               trailing: Row(
//                                                 mainAxisSize: MainAxisSize.min,
//                                                 children: [
//                                                   GestureDetector(
//                                                       onTap: !ignoreTimeComponentsforDateComparisonExpiration(
//                                                                   job
//                                                                       .targetStartDate,
//                                                                   job
//                                                                       .targetEndDate) ||
//                                                               job.status ==
//                                                                   'Completed' ||
//                                                               job.status ==
//                                                                   'Terminated' ||
//                                                               job.status ==
//                                                                   'Closed'
//                                                           ? null
//                                                           : () {
//                                                               final myJobsContext =
//                                                                   context;
//                                                               showDialog(
//                                                                   context:
//                                                                       context,
//                                                                   builder: (context) => showStartMyjobsDialog(
//                                                                       myJobsBlocContext:
//                                                                           myJobsContext,
//                                                                       dialogContext:
//                                                                           context,
//                                                                       job: job,
//                                                                       project:
//                                                                           project));
//                                                             },
//                                                       child: !ignoreTimeComponentsforDateComparisonExpiration(
//                                                                   job
//                                                                       .targetStartDate,
//                                                                   job
//                                                                       .targetEndDate) ||
//                                                               job.status ==
//                                                                   'Completed' ||
//                                                               job.status ==
//                                                                   'Terminated' ||
//                                                               job.status ==
//                                                                   'Closed'
//                                                           ? const Icon(
//                                                               Icons
//                                                                   .play_circle_outline,
//                                                               color:
//                                                                   Colors.grey)
//                                                           : const Icon(
//                                                               Icons.play_circle_outline,
//                                                               color: Colors.green)),
//                                                 ],
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                       ),
//                                   ],
//                                 ),
//                               );
//                             },
//                           ),
//                   ),
//                 ],
//               ),
//               floatingActionButton: BlocBuilder<MyJobsBloc, MyJobsState>(
//                 builder: (blocContext, state) {
//                   if (state.projects.isNotEmpty) {
//                     return FloatingActionButton(
//                       backgroundColor: Theme.of(blocContext).primaryColor,
//                       child: const Icon(Icons.add),
//                       onPressed: () async {
//                         final currentUser = state.currentUserInfo?.userKey;
//                         if (currentUser == null) return;

//                         await CustomBottomSheet.show<Map<String, dynamic>>(
//                           context: blocContext,
//                           height: MediaQuery.of(blocContext).size.height * 0.7,
//                           title: 'add_job'.tr(),
//                           hasLeadingIcon: false,
//                           hasSecondaryHeaderWidget: true,
//                           secondaryHeaderWidget:
//                               (secondaryHeaderWidgetContext) {
//                             final neutralColor = Theme.of(blocContext)
//                                 .colorScheme
//                                 .onSurfaceVariant;

//                             return IconButton(
//                               onPressed: () =>
//                                   Navigator.of(blocContext, rootNavigator: true)
//                                       .pop(),
//                               icon: Icon(Icons.close, color: neutralColor),
//                             );
//                           },
//                           child: Navigator(
//                             clipBehavior: Clip.none,
//                             onGenerateRoute: (settings) {
//                               return MaterialPageRoute(
//                                 builder: (context) => AddJobSelectProject(
//                                   projects: state.projects,
//                                   jobs: state.jobs,
//                                   clients: state.clients,
//                                   isCalendar: false,
//                                   currentUser: currentUser,
//                                   onJobCreated: (payload) {
//                                     blocContext
//                                         .read<MyJobsBloc>()
//                                         .add(AddJob(payload: payload));
//                                   },
//                                 ),
//                                 settings: settings,
//                               );
//                             },
//                           ),
//                         );
//                       },
//                     );
//                   } else {
//                     return SizedBox.shrink();
//                   }
//                 },
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
