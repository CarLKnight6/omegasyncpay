import 'package:coamplifi_pro/config/app_config.dart';
import 'package:coamplifi_pro/di.dart';
import 'package:coamplifi_pro/domain/calendar/calendar_usecase_type.dart';
import 'package:coamplifi_pro/data/dto/projects_dto.dart';
import 'package:coamplifi_pro/domain/auth/user_key.dart';
import 'package:coamplifi_pro/model/client.dart';
import 'package:coamplifi_pro/model/deliverable.dart';
import 'package:coamplifi_pro/model/job.dart';
import 'package:coamplifi_pro/presentation/my_jobs/widgets/job_form.dart';
import 'package:coamplifi_pro/presentation/theme/design_token.dart';
import 'package:coamplifi_pro/presentation/widgets/bottom_sheet.dart';
import 'package:coamplifi_pro/presentation/widgets/cs_chip.dart';
import 'package:coamplifi_pro/presentation/widgets/text_widget.dart';
import 'package:coamplifi_pro/utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

String _getStatus(String status) {
  switch (status) {
    case "Planned":
      return "In Plan";
    case "Active":
      return "Active";
    default:
      return "";
  }
}

Color _getChipLabelColor(String status) {
  switch (status) {
    case "Planned":
      return StyleDictionaryColor.systemColorsInfoMain;
    case "Active":
      return StyleDictionaryColor.primary;
    default:
      return StyleDictionaryColor.primary;
  }
}

Color _getChipColor(String status) {
  switch (status) {
    case "Planned":
      return StyleDictionaryColor.systemColorsInfoLightbg;
    case "Active":
      return Color(0xFFFEEFE3);
    default:
      return Color(0xFFFEEFE3);
  }
}

Widget _renderProjectContainer(
    {required ProjectsListDTO project,
    required List<Job> jobs,
    void Function()? onTap}) {
  String initial = project.workKey?.title?.isNotEmpty == true
      ? project.workKey!.title![0]
      : '';

  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: StyleDictionaryColor.systemColorsOtherStroke),
      borderRadius: BorderRadius.circular(10),
    ),
    margin: EdgeInsets.only(bottom: 8),
    child: ListTile(
      dense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      leading: SizedBox(
        width: 25.0,
        height: 25.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Container(
            color: Color(0xFF7C63E3),
            alignment: Alignment.center,
            child: TextWidget(
                text: initial,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: StyleDictionaryColor.systemColorsPrimaryContrasttext),
          ),
        ),
      ),
      minLeadingWidth: 0,
      title: TextWidget(
          text: project.workKey?.title ?? '',
          fontSize: 16,
          fontWeight: FontWeight.w600),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CsChip(
            label: _getStatus(project.status ?? ''),
            labelColor: _getChipLabelColor(project.status ?? ''),
            chipColor: _getChipColor(project.status ?? ''),
            shrinkWrap: true,
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.transparent,
            child: ClipOval(
              child: Image.network(
                '${AppConfig.shared.baseDomain}/cs/image/${project.creator?.shardKey}/avatar.jpeg',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/default-avatar.jpeg',
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
        ],
      ),
      onTap: onTap,
    ),
  );
}

/// Abstract base class for items displayed in the jobs list.
abstract class DisplayItem {}

/// Represents a header item in the project list, e.g., "No Client" or a client name.
class HeaderItem extends DisplayItem {
  final String title;
  final bool hasClient;

  HeaderItem(this.title, this.hasClient);
}

/// Represents a project group header in the jobs list.
class ProjectItem extends DisplayItem {
  final String projectTitle;
  final ProjectsListDTO project;
  final List<Job> jobs;
  ProjectItem(this.projectTitle, this.project, this.jobs);
}

/// When provided, Add Job flow uses callback and closes inner sheets only
/// (JobList stays open for user to select the new job).
/// When null, pops with payload for parent to handle (e.g. MyJobsPage).
typedef OnJobCreatedPayload = void Function(Map<String, dynamic> payload);

class AddJobSelectProject extends StatefulWidget {
  final List<ProjectsListDTO> projects;
  final List<Job> jobs;
  final List<Client> clients;
  final bool isCalendar;
  final UserKey currentUser;

  final OnJobCreatedPayload? onJobCreated;

  const AddJobSelectProject({
    super.key,
    required this.projects,
    required this.jobs,
    required this.clients,
    required this.isCalendar,
    required this.currentUser,
    this.onJobCreated,
  });

  @override
  State<AddJobSelectProject> createState() => _AddJobSelectProjectState();
}

class _AddJobSelectProjectState extends State<AddJobSelectProject> {
  List<DisplayItem> _displayItems = [];

  @override
  void initState() {
    super.initState();
    _buildDisplayItems();
  }

  /// Checks if a project has any associated jobs.
  ///
  /// Uses different matching logic based on the context:
  /// - When `isCalendar` is true: matches jobs by `projectId` field
  /// - When `isCalendar` is false: matches jobs by `workKey.aggregateId` field
  ///
  /// Returns true if at least one job is associated with the given project.
  bool _checkProjectHasJobs(ProjectsListDTO project) {
    return widget.jobs.any((job) {
      if (widget.isCalendar) {
        return job.projectId == project.workKey?.aggregateId;
      } else {
        return job.workKey?.aggregateId == project.workKey?.aggregateId;
      }
    });
  }

  void _buildDisplayItems() {
    _displayItems.clear();

    // Filter projects: status must be "Planned" or "Active" and endDate must not have passed
    final now = DateTime.now();
    final filteredProjects = widget.projects.where((project) {
      // Check status
      final status = ProjectStatusExtension.fromString(project.status);
      if (status != ProjectStatus.PrePlan &&
          status != ProjectStatus.Planned &&
          status != ProjectStatus.Active) {
        return false;
      }

      // NOTE: keeping this commented out for now in case we need to filter projects with these parameters in the future
      // Check endDate
      // if (project.endDate != null && project.endDate!.isNotEmpty) {
      //   try {
      //     final endDate = DateTime.parse(project.endDate!);
      //     if (endDate.isBefore(now)) {
      //       return false;
      //     }
      //   } catch (e) {
      //     return false;
      //   }
      // }

      // Check if project has jobs
      // if (!_checkProjectHasJobs(project)) {
      //   return false;
      // }

      return true;
    }).toList();

    final projectsWithNoClient =
        filteredProjects.where((element) => element.clientId == null).toList();
    if (projectsWithNoClient.isNotEmpty) {
      _displayItems.add(HeaderItem('No Client', false));
      for (ProjectsListDTO project in projectsWithNoClient) {
        // List the jobs included on the project by matching id
        List<Job> jobs = widget.jobs.where((job) {
          String? jobId =
              widget.isCalendar ? job.projectId : job.workKey?.aggregateId;
          return jobId == project.workKey?.aggregateId;
        }).toList();
        _displayItems
            .add(ProjectItem(project.workKey?.title ?? '', project, jobs));
      }
    }

    // Build a list of unique clients that have at least one matching project
    // in `filteredProjects` (project.clientId != null and equals client.id).
    final clientsWithProject = widget.clients.where((client) {
      return filteredProjects.any(
        (project) => project.clientId != null && project.clientId == client.id,
      );
    }).toList();

    if (clientsWithProject.isNotEmpty) {
      for (Client client in clientsWithProject) {
        _displayItems.add(HeaderItem(client.name ?? '', true));

        List<ProjectsListDTO> projects = filteredProjects
            .where((project) => project.clientId == client.id)
            .toList();

        for (ProjectsListDTO project in projects) {
          // List the jobs included on the project by matching id
          List<Job> jobs = widget.jobs.where((job) {
            String? jobId =
                widget.isCalendar ? job.projectId : job.workKey?.aggregateId;
            return jobId == project.workKey?.aggregateId;
          }).toList();
          _displayItems
              .add(ProjectItem(project.workKey?.title ?? '', project, jobs));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StyleDictionaryColor.systemColorsBackgroundPaper,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
              text: 'select_project'.tr(),
              fontSize: 16,
              fontWeight: FontWeight.w600),
          const SizedBox(height: 10),
          Flexible(
            child: ListView.builder(
              itemCount: _displayItems.length,
              itemBuilder: (context, index) {
                final item = _displayItems[index];
                if (item is HeaderItem) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      TextWidget(
                        text: item.title,
                        textStyle: !item.hasClient
                            ? Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(fontStyle: FontStyle.italic)
                            : null,
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                } else if (item is ProjectItem) {
                  final project = item.project;
                  final jobs = item.jobs;

                  return _renderProjectContainer(
                    project: project,
                    jobs: jobs,
                    onTap: () async {
                      String projectName =
                          project.workKey?.title?.isNotEmpty == true
                              ? project.workKey!.title!
                              : '';
                      String projectNameInitial =
                          projectName.isNotEmpty ? projectName[0] : '';
                      Client? client;
                      if (project.clientId != null) {
                        try {
                          client = widget.clients
                              .firstWhere((c) => c.id == project.clientId);
                        } catch (_) {
                          client = null;
                        }
                      } else {
                        client = null;
                      }

                      final projectId = project.workKey?.aggregateId ?? '';
                      final result = await getIt<CalendarUsecaseType>()
                          .getDeliverables(projectId, false, true, true);
                      final deliverables =
                          result.fold((l) => <Deliverable>[], (r) => r);

                      final payload =
                          await CustomBottomSheet.show<Map<String, dynamic>>(
                        context: context,
                        title: 'add_job'.tr(),
                        height: MediaQuery.of(context).size.height * 0.7,
                        useCustomTitle: true,
                        centerTitle: false,
                        hasLeadingIcon: false,
                        hasSecondaryHeaderWidget: true,
                        secondaryHeaderWidget: (secondaryHeaderWidgetContext) {
                          Color buttonColor =
                              StyleDictionaryColor.systemColorsNeutralMain;

                          return Row(
                            children: [
                              IconButton(
                                constraints: BoxConstraints(),
                                padding: EdgeInsets.zero,
                                onPressed: () {},
                                icon: Icon(Icons.more_vert, color: buttonColor),
                              ),
                              IconButton(
                                onPressed: () =>
                                    Navigator.of(context, rootNavigator: true)
                                        .pop(),
                                icon: Icon(Icons.close, color: buttonColor),
                              ),
                            ],
                          );
                        },
                        customTitleWidget: Row(
                          children: [
                            SizedBox(
                              width: 25.0,
                              height: 25.0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Container(
                                  color: Color(0xFF7C63E3),
                                  alignment: Alignment.center,
                                  child: TextWidget(
                                    text: projectNameInitial,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextWidget(
                                text: projectName,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                maxLines: 1,
                              ),
                            ),
                            if (client != null) ...[
                              const SizedBox(width: 10),
                              TextWidget(
                                text: client.name ?? '',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: StyleDictionaryColor
                                    .systemColorsTextDisabled,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ],
                        ),
                        child: Navigator(
                          onGenerateRoute: (settings) {
                            return MaterialPageRoute(
                              builder: (context) => JobForm(
                                project: project,
                                client: client,
                                currentUser: widget.currentUser,
                                deliverables: deliverables,
                                createBtnOnTap: widget.onJobCreated != null
                                    ? (p) => widget.onJobCreated!(p)
                                    : null,
                                isAddingNewJob: true,
                              ),
                              settings: settings,
                            );
                          },
                        ),
                      );
                      if (context.mounted) {
                        Navigator.of(context, rootNavigator: true).pop();
                      }
                    },
                  );
                }
                return const SizedBox.shrink(); // Should not happen
              },
            ),
          ),
        ],
      ),
    );
  }
}
