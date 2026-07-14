// import 'dart:io' as io show Directory, File;
// import 'dart:math';
// import 'package:coamplifi_pro/config/app_config.dart';
// import 'package:coamplifi_pro/data/dto/calendar_event_dto.dart' hide Color;
// import 'package:coamplifi_pro/data/dto/job_payload_dto.dart';
// import 'package:coamplifi_pro/data/dto/notes_dto.dart';
// import 'package:coamplifi_pro/domain/auth/current_user_info.dart';
// import 'package:coamplifi_pro/model/client.dart';
// import 'package:coamplifi_pro/model/deliverable.dart';
// import 'package:coamplifi_pro/model/job.dart';
// import 'package:coamplifi_pro/presentation/clipboard/utils/const.dart';
// import 'package:coamplifi_pro/presentation/my_jobs/bloc/my_jobs_bloc.dart';
// import 'package:coamplifi_pro/presentation/my_jobs/widgets/duration_dialog.dart';
// import 'package:coamplifi_pro/presentation/theme/constants.dart';
// import 'package:coamplifi_pro/presentation/widgets/bottom_sheet.dart';
// import 'package:coamplifi_pro/presentation/widgets/note_bottom_sheet.dart';
// import 'package:coamplifi_pro/presentation/widgets/standard_text_button.dart';
// import 'package:coamplifi_pro/presentation/widgets/text_widget.dart';
// import 'package:coamplifi_pro/presentation/widgets/textformfield_widget.dart';
// import 'package:coamplifi_pro/utils/function/datetime_formatting.dart';
// import 'package:coamplifi_pro/utils/util.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_quill/flutter_quill.dart';
// import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
// import 'package:intl/intl.dart';
// import 'package:path/path.dart' as path;
// import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';
// import 'package:flutter_quill_delta_from_html/flutter_quill_delta_from_html.dart';

// showAddMyjobsDialog(
//     List<Deliverable> deliverable,
//     MyJobsState state,
//     BuildContext dialogContext,
//     int index,
//     CurrentUserInfo currentUserInfo,
//     int jobIndex,
//     bool isAddingNewJob,
//     Job jobData,
//     bool isEditable) {
//   Color getJobStatus(String status) {
//     switch (status) {
//       case 'Active':
//         return Colors.orange;
//       case 'Planned' || 'PrePlan':
//         return Colors.blue;
//       case 'Proposal':
//         return Colors.red;

//       default:
//         return Colors.grey;
//     }
//   }

//   String jobStatus = '';

//   final _random = Random();
//   DateTimeRange? dateRange;

//   final Color projectColor =
//       Colors.primaries[_random.nextInt(Colors.primaries.length)];

//   final clientName = state.clients
//           .firstWhere((client) => client.id == state.projects[index].clientId,
//               orElse: () => Client(name: ''))
//           .name ??
//       '';

//   // Get all jobs for this project
//   final projectJobs = state.jobs
//       .where((job) =>
//           job.workKey!.aggregateId ==
//           state.projects[index].workKey!.aggregateId)
//       .toList();

//   // Get the current job using jobIndex from projectJobs
//   final currentJob = jobData;

//   String selectedPriorityValue = priorityFilter[2].value;
//   Color selectedColor = priorityFilter[2].color;
//   IconData selectedIcon = priorityFilter[2].icon;

//   // Get project's start and end dates for validation
//   final String projectStartDateString = currentJob?.targetStartDate ?? '';
//   final String projectEndDateString = currentJob?.targetEndDate ?? '';

//   final DateTime projectStartDate = projectStartDateString.isNotEmpty
//       ? DateTime.parse(projectStartDateString)
//       : DateTime.now();
//   final DateTime projectEndDate = projectEndDateString.isNotEmpty
//       ? DateTime.parse(projectEndDateString)
//       : DateTime.now().add(Duration(days: 365));

//   if (isAddingNewJob) {
//     selectedPriorityValue = priorityFilter[2].value;
//     selectedColor = priorityFilter[2].color;
//     selectedIcon = priorityFilter[2].icon;
//     // Ensure job start date is not earlier than project start date
//     final DateTime startDate = projectStartDate;
//     final DateTime endDate =
//         startDate.add(Duration(days: 95)).isAfter(projectEndDate)
//             ? projectEndDate
//             : startDate.add(Duration(days: 95));
//     dateRange = DateTimeRange(start: startDate, end: endDate);
//   } else {
//     // Parse dates from backend with auto-correction
//     DateTime startDate;
//     DateTime endDate;

//     try {
//       startDate = DateTime.parse(currentJob?.targetStartDate ?? '');
//       endDate = DateTime.parse(currentJob?.targetEndDate ?? '');
//     } catch (e) {
//       startDate = DateTime.now();
//       endDate = DateTime.now().add(Duration(days: 95));
//     }

//     if (startDate.isBefore(projectStartDate)) {
//       startDate = projectStartDate;
//     }
//     if (endDate.isAfter(projectEndDate)) {
//       endDate = projectEndDate;
//     }

//     if (endDate.isBefore(startDate) || endDate == startDate) {
//       final defaultEnd = startDate.add(Duration(days: 95));
//       endDate =
//           defaultEnd.isAfter(projectEndDate) ? projectEndDate : defaultEnd;
//     }

//     if (startDate.isAfter(endDate)) {
//       startDate = DateTime.now();
//       endDate = DateTime.now().add(Duration(days: 95));
//       if (startDate.isBefore(projectStartDate)) {
//         startDate = projectStartDate;
//       }
//       if (endDate.isAfter(projectEndDate)) {
//         endDate = projectEndDate;
//       }
//     }

//     dateRange = DateTimeRange(start: startDate, end: endDate);

//     selectedPriorityValue = priorityFilter
//         .firstWhere(
//           (item) => item.value == currentJob?.priority,
//           orElse: () => priorityFilter[2],
//         )
//         .value;

//     selectedColor = priorityFilter
//         .firstWhere(
//           (item) => item.value == currentJob?.priority,
//           orElse: () => priorityFilter[2],
//         )
//         .color;

//     selectedIcon = priorityFilter
//         .firstWhere(
//           (item) => item.value == currentJob?.priority,
//           orElse: () => priorityFilter[2],
//         )
//         .icon;
//   }

//   bool showDescription = false;

//   // --- FIX 1: LOAD EXISTING DESCRIPTION & PREVENT EMPTY DELTA CRASH ---
//   final String existingHtml =
//       (isAddingNewJob ? '' : currentJob?.description) ?? '';
//   final QuillController _quillController =
//       (existingHtml.isNotEmpty && existingHtml != "<p><br></p>")
//           ? QuillController(
//               document: Document.fromDelta(HtmlToDelta().convert(existingHtml)),
//               selection: const TextSelection.collapsed(offset: 0),
//             )
//           : QuillController.basic(
//               config: QuillControllerConfig(
//                 clipboardConfig: QuillClipboardConfig(
//                   enableExternalRichPaste: true,
//                   onImagePaste: (imageBytes) async {
//                     if (imageBytes == null) return null;
//                     final newFileName =
//                         'image-${DateTime.now().toIso8601String()}.png';
//                     final newPath =
//                         path.join(io.Directory.systemTemp.path, newFileName);
//                     final file = await io.File(newPath)
//                         .writeAsBytes(imageBytes, flush: true);
//                     return file.path;
//                   },
//                 ),
//               ),
//             );

//   final TextEditingController jobName = isAddingNewJob
//       ? TextEditingController()
//       : TextEditingController(text: currentJob?.name);

//   return StatefulBuilder(
//     builder: (context, setState) {
//       bool isSaveEnabled = jobName.text.isNotEmpty && dateRange != null;

//       jobName.addListener(() {
//         setState(() {});
//       });

//       return Container(
//         child: BlocListener<MyJobsBloc, MyJobsState>(
//           listener: (context, state) {
//             if (state is AddNewJobSucess) {
//               setState(() {
//                 jobStatus = state.job?.status ?? '';
//               });
//             }
//           },
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // PROJECT HEADER
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(6),
//                       child: Container(
//                         width: 30,
//                         height: 30,
//                         color: projectColor,
//                         alignment: Alignment.center,
//                         child: Text(
//                           state.projects[index].workKey!.title!.isNotEmpty
//                               ? state.projects[index].workKey!.title![0]
//                                   .toUpperCase()
//                               : '?',
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: TextWidget(
//                         maxLines: 1,
//                         text: state.projects[index].workKey?.title ?? '',
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     if (state.projects[index].clientId.toString().isNotEmpty)
//                       SizedBox(
//                         width: MediaQuery.of(dialogContext).size.width * 0.31,
//                         child: TextWidget(
//                           text: clientName,
//                           fontSize: 13,
//                           color: Colors.grey,
//                           fontWeight: FontWeight.w600,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                   ],
//                 ),

//                 const SizedBox(height: 10),

//                 // JOB NAME FIELD
//                 TextFormFieldWidget(
//                   enabled: isEditable,
//                   height: 50,
//                   label: 'Job Name',
//                   textFieldController: jobName,
//                 ),
//                 const SizedBox(height: 20),

//                 // ADD DESCRIPTION BUTTON
//                 StandardTextButton(
//                   onPressed: isEditable
//                       ? () {
//                           setState(
//                             () {
//                               showDescription = !showDescription;
//                             },
//                           );
//                         }
//                       : null,
//                   style: TextButton.styleFrom(
//                     padding: EdgeInsets.zero,
//                     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                     minimumSize: const Size(0, 0),
//                   ),
//                   icon: const Icon(Icons.add, size: 30),
//                   label: TextWidget(
//                     enabled: isEditable,
//                     text: 'Add Description',
//                     color: Colors.grey,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 if (showDescription) ...[
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       InputDecorator(
//                         decoration: InputDecoration(
//                           labelText: "Description",
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           floatingLabelBehavior: FloatingLabelBehavior.auto,
//                           contentPadding: const EdgeInsets.all(12),
//                         ),
//                         child: SizedBox(
//                           height: 35,
//                           child: QuillEditor(
//                             controller: _quillController,
//                             focusNode: FocusNode(),
//                             scrollController: ScrollController(),
//                             config: QuillEditorConfig(
//                               padding: EdgeInsets.zero,
//                               placeholder: '',
//                               embedBuilders:
//                                   FlutterQuillEmbeds.editorBuilders(),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 5),
//                       QuillSimpleToolbar(
//                         controller: _quillController,
//                         config: QuillSimpleToolbarConfig(
//                             showClipboardPaste: false,
//                             toolbarSectionSpacing: 2,
//                             multiRowsDisplay: false,
//                             toolbarIconAlignment: WrapAlignment.start,
//                             headerStyleType: HeaderStyleType.original,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(1.0)),
//                             showAlignmentButtons: false,
//                             showLineHeightButton: false,
//                             showListCheck: false,
//                             showCodeBlock: false,
//                             showLink: false,
//                             showQuote: false,
//                             showSearchButton: false,
//                             showClipboardCopy: false,
//                             showClipboardCut: false,
//                             showIndent: false,
//                             showFontSize: false,
//                             showListBullets: true,
//                             showListNumbers: true,
//                             showFontFamily: false,
//                             showStrikeThrough: true,
//                             showInlineCode: false,
//                             showSubscript: false,
//                             showSuperscript: false,
//                             showBackgroundColorButton: false,
//                             showClearFormat: false,
//                             showHeaderStyle: true,
//                             showColorButton: false,
//                             showRedo: false,
//                             showUndo: false),
//                       ),
//                     ],
//                   ),
//                 ],

//                 const SizedBox(height: 30),

//                 // DATE RANGE PICKER
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     StandardTextButton(
//                       style: TextButton.styleFrom(
//                         padding: EdgeInsets.zero,
//                         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                         minimumSize: const Size(0, 0),
//                       ),
//                       icon: const Icon(Icons.today, size: 30),
//                       label: const TextWidget(
//                         text: 'Set Date Range',
//                         color: Colors.grey,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                       ),
//                       onPressed: isEditable
//                           ? () async {
//                               final DateTimeRange? picked =
//                                   await showDateRangePicker(
//                                 context: context,
//                                 firstDate: projectStartDate,
//                                 lastDate: projectEndDate,
//                                 initialDateRange: dateRange,
//                                 builder: (context, child) {
//                                   return Center(
//                                     child: ConstrainedBox(
//                                       constraints: const BoxConstraints(
//                                         maxWidth: 400,
//                                         maxHeight: 600,
//                                       ),
//                                       child: Theme(
//                                         data: Theme.of(context).copyWith(
//                                           colorScheme: ColorScheme.light(
//                                             primary: primary,
//                                             onPrimary: Colors.white,
//                                             onSurface: Colors.black,
//                                           ),
//                                         ),
//                                         child: child!,
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               );

//                               if (picked != null) {
//                                 // Auto-correct dates to be within project bounds
//                                 DateTime correctedStart = picked.start;
//                                 DateTime correctedEnd = picked.end;

//                                 // Enforce project date boundaries
//                                 if (correctedStart.isBefore(projectStartDate)) {
//                                   correctedStart = projectStartDate;
//                                 }
//                                 if (correctedEnd.isAfter(projectEndDate)) {
//                                   correctedEnd = projectEndDate;
//                                 }

//                                 // Ensure start <= end
//                                 if (correctedStart.isAfter(correctedEnd)) {
//                                   correctedEnd = correctedStart;
//                                 }

//                                 // Show warning if dates were corrected
//                                 if (correctedStart != picked.start ||
//                                     correctedEnd != picked.end) {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                       content: Text(
//                                           'Dates adjusted to fit within project range (${DateFormat('MMM d, yyyy').format(projectStartDate)} - ${DateFormat('MMM d, yyyy').format(projectEndDate)})'),
//                                       backgroundColor: Colors.orange,
//                                     ),
//                                   );
//                                 }

//                                 setState(() {
//                                   dateRange = DateTimeRange(
//                                       start: correctedStart, end: correctedEnd);
//                                 });
//                               }
//                             }
//                           : null,
//                     ),
//                     TextWidget(
//                       text: dateRange != null
//                           ? '${DateFormat('MMM d').format(dateRange!.start)} - ${DateFormat('MMM d, yyyy').format(dateRange!.end)}'
//                           : 'No date selected',
//                       color: Colors.grey,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 20),

//                 // USER INFO
//                 ListTile(
//                   contentPadding: EdgeInsets.zero,
//                   minLeadingWidth: 0,
//                   horizontalTitleGap: 8,
//                   leading: CircleAvatar(
//                     radius: 15,
//                     backgroundColor: Colors.transparent,
//                     child: ClipOval(
//                       child: Image.network(
//                         '${AppConfig.shared.baseDomain}/cs/image/${currentUserInfo.userKey.shardKey}/avatar.jpeg',
//                         fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) {
//                           return Image.asset(
//                             'assets/images/default-avatar.jpeg',
//                             fit: BoxFit.cover,
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                   title: TextWidget(
//                     text:
//                         '${currentUserInfo.userKey.firstName} ${currentUserInfo.userKey.lastName}',
//                     color: Colors.grey,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 // PRIORITY PICKER
//                 StandardTextButton(
//                   style: TextButton.styleFrom(
//                     padding: EdgeInsets.zero,
//                     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                     minimumSize: const Size(0, 0),
//                   ),
//                   icon: SizedBox(
//                     width: 30,
//                     height: 30,
//                     child: Icon(
//                       selectedIcon,
//                       color: selectedColor,
//                       size: 30,
//                     ),
//                   ),
//                   label: TextWidget(
//                     text: selectedPriorityValue,
//                     color: selectedColor,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                   ),
//                   onPressed: isEditable
//                       ? () async {
//                           final result = await showMenu<PriorityItem>(
//                             context: context,
//                             position:
//                                 const RelativeRect.fromLTRB(100, 500, 100, 0),
//                             items: [
//                               for (final item in priorityFilter)
//                                 PopupMenuItem<PriorityItem>(
//                                   value: item,
//                                   child: Row(
//                                     children: [
//                                       SizedBox(
//                                         width: 20,
//                                         height: 20,
//                                         child: Icon(item.icon,
//                                             color: item.color, size: 20),
//                                       ),
//                                       const SizedBox(width: 10),
//                                       TextWidget(
//                                         text: item.value,
//                                         color: item.color,
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                             ],
//                           );

//                           if (result != null) {
//                             setState(() {
//                               selectedPriorityValue = result.value;
//                               selectedColor = result.color;
//                               selectedIcon = result.icon;
//                             });
//                           }
//                         }
//                       : null,
//                 ),

//                 const SizedBox(height: 20),

//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     GestureDetector(
//                       onTap: () async {
//                         await showModalBottomSheet(
//                           backgroundColor: Colors.white,
//                           isScrollControlled: true,
//                           shape: const RoundedRectangleBorder(
//                             borderRadius:
//                                 BorderRadius.vertical(top: Radius.circular(20)),
//                           ),
//                           context: context,
//                           builder: (dialogContext) {
//                             return DraggableScrollableSheet(
//                               initialChildSize: 0.65,
//                               minChildSize: 0.6,
//                               maxChildSize: 0.95,
//                               expand: false,
//                               builder: (context2, scrollController) {
//                                 return showDurationDialog(
//                                   taskList: const <TaskDTO>[],
//                                   job: currentJob,
//                                 );
//                               },
//                             );
//                           },
//                         );
//                       },
//                       child: RichText(
//                         text: TextSpan(
//                           text: 'Total Duration\n',
//                           style: normalText.copyWith(
//                             color: Colors.grey,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w600,
//                           ),
//                           children: <TextSpan>[
//                             TextSpan(
//                                 text: '00:00:00',
//                                 style: TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.black)),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const Icon(Icons.play_circle_outline, color: Colors.green),
//                   ],
//                 ),
//                 const SizedBox(height: 20),

//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     StandardTextButton(
//                       style: TextButton.styleFrom(
//                         padding: EdgeInsets.zero,
//                         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                         minimumSize: Size.zero,
//                       ),
//                       icon: Icon(Icons.today_outlined),
//                       label: TextWidget(
//                           color: Colors.grey,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           text:
//                               '${DateFormat('MMM d').format(dateRange!.start)} - ${DateFormat('MMM d, yyyy').format(dateRange!.end)}'),
//                     ),
//                     StandardTextButton(
//                       style: TextButton.styleFrom(
//                         padding: EdgeInsets.zero,
//                         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                         minimumSize: Size.zero,
//                       ),
//                       icon: Icon(Icons.timer_outlined),
//                       label: TextWidget(
//                           color: Colors.grey,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           text: '1 hr'),
//                     ),
//                     GestureDetector(
//                       onTap: () async {
//                         final jobId = currentJob?.id ?? '';

//                         if (jobId.isEmpty) {
//                           print('Job ID not available');
//                           return;
//                         }

//                         context.read<MyJobsBloc>().add(
//                               LoadNotes(jobId: jobId),
//                             );

//                         CustomBottomSheet.show(
//                           height: MediaQuery.of(context).size.height * 0.5,
//                           context: context,
//                           title: 'notes'.tr(),
//                           hasSecondaryHeaderWidget: false,
//                           child: BlocProvider.value(
//                             value: context.read<MyJobsBloc>(),
//                             child: BlocBuilder<MyJobsBloc, MyJobsState>(
//                               builder: (context, state) {
//                                 List<NotesDTO>? notes = state.notes;

//                                 return NoteBottomSheet(
//                                   taskId: jobId,
//                                   assignee: currentJob.assignee,
//                                   task: null,
//                                   blocContext: context,
//                                   notes: notes,
//                                   onAddNote: (note) {
//                                     final payload = {
//                                       "author": currentJob.assignee?.toJson(),
//                                       'checkinType': "None",
//                                       "details": note.trim(),
//                                       "forUser": currentJob.assignee?.toJson(),
//                                       "html": false,
//                                       "refId": notes?.isNotEmpty ?? false
//                                           ? notes?.first.refId ?? ''
//                                           : '',
//                                       "refType": "Job"
//                                     };
//                                     context.read<MyJobsBloc>().add(
//                                           AddJobNote(
//                                             payload: payload,
//                                           ),
//                                         );
//                                   },
//                                   onDeleteNote: (noteId) {
//                                     context
//                                         .read<MyJobsBloc>()
//                                         .add(DeleteJobNote(noteId: noteId));
//                                   },
//                                   onEditNote: (note, noteText) {
//                                     final payload = note?.toJson();
//                                     payload?['details'] = noteText.trim();
//                                     payload?['my'] = true;

//                                     // Parse addedAt and convert to UTC ISO 8601 format with Z suffix
//                                     final parsedDate =
//                                         parseAsLocalTime(note?.addedAt ?? '');
//                                     payload?['parsedAddedAt'] =
//                                         parsedDate.toUtc().toIso8601String();

//                                     context.read<MyJobsBloc>().add(EditJobNote(
//                                           jobId: jobId,
//                                           noteId: note?.id ?? '',
//                                           payload: payload ?? {},
//                                         ));
//                                   },
//                                 );
//                               },
//                             ),
//                           ),
//                         );
//                       },
//                       child: Icon(Icons.sticky_note_2),
//                     )
//                   ],
//                 ),
//                 const SizedBox(height: 10),

//                 // SAVE BUTTON
//                 SizedBox(
//                   width: double.infinity,
//                   child: StandardTextButton(
//                     style: TextButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 24, vertical: 12),
//                       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                       minimumSize: const Size(0, 0),
//                       backgroundColor: isSaveEnabled && isEditable
//                           ? Theme.of(context).primaryColor
//                           : Colors.grey.shade400,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     label: const TextWidget(
//                       text: 'Save',
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                     onPressed: isSaveEnabled && isEditable
//                         ? () {
//                             final deltaOps =
//                                 _quillController.document.toDelta().toJson();
//                             final converter = QuillDeltaToHtmlConverter(
//                                 deltaOps, ConverterOptions.forEmail());

//                             // --- FIX 2: EXTRA SYMBOLS SANITIZER ---
//                             final String htmlDescriptionRaw =
//                                 converter.convert();
//                             final String htmlDescription =
//                                 (htmlDescriptionRaw.trim() == "<p><br></p>" ||
//                                         htmlDescriptionRaw.trim() == "<p></p>")
//                                     ? ""
//                                     : htmlDescriptionRaw;

//                             DateTime safeStartDate = dateRange!.start;
//                             DateTime safeEndDate = dateRange!.end;

//                             if (safeStartDate.isBefore(projectStartDate)) {
//                               safeStartDate = projectStartDate;
//                             }
//                             if (safeEndDate.isAfter(projectEndDate)) {
//                               safeEndDate = projectEndDate;
//                             }
//                             if (safeStartDate.isAfter(safeEndDate)) {
//                               safeEndDate = safeStartDate;
//                             }

//                             final String jobStartDateString =
//                                 DateFormat('yyyy-MM-dd').format(safeStartDate);
//                             final String jobEndDateString =
//                                 DateFormat('yyyy-MM-dd').format(safeEndDate);

//                             if (isAddingNewJob) {
//                               context.read<MyJobsBloc>().add(AddNewJob(
//                                     jobPayloadDTO: JobPayloadDTO(
//                                       tenantId: deliverable.first.tenantId,
//                                       doctype: 'ProjectJobDTO',
//                                       assignee: currentUserInfo.userKey,
//                                       creator: currentUserInfo.userKey,
//                                       cfPairs: [],
//                                       completionPercentage: 0,
//                                       deliverableId: deliverable.first.id,
//                                       deliverableName: deliverable.first.name,
//                                       description: htmlDescription,
//                                       drawerMenu: null,
//                                       name: jobName.text,
//                                       periodDisplay:
//                                           '${DateFormat('MMM d, yyyy').format(safeStartDate)} - ${DateFormat('MMM d, yyyy').format(safeEndDate)}',
//                                       permission: null,
//                                       priority: selectedPriorityValue,
//                                       status: "Planned",
//                                       targetEndDate: jobEndDateString,
//                                       targetStartDate: jobStartDateString,
//                                       tasks: [],
//                                       unitOfWorks: 1,
//                                       workKey: state.projects[index].workKey,
//                                       createdBy:
//                                           currentUserInfo.userKey.aggregateId,
//                                       modifiedBy:
//                                           currentUserInfo.userKey.aggregateId,
//                                       createdAt:
//                                           DateTime.now().toIso8601String(),
//                                       modifiedAt:
//                                           DateTime.now().toIso8601String(),
//                                       attachments: [],
//                                       checkinType: null,
//                                       completedBy: null,
//                                       closedBy: null,
//                                       completedAt: null,
//                                       closedAt: null,
//                                       milestoneId: null,
//                                       milestoneName: null,
//                                       startDate: null,
//                                       endDate: null,
//                                       initialFlag: null,
//                                       currentFlag: null,
//                                       flagId: null,
//                                       myProject: true,
//                                       myOwn: true,
//                                       usingDefaultDateRange: true,
//                                       start: safeStartDate.toIso8601String(),
//                                       end: safeEndDate.toIso8601String(),
//                                       expired: false,
//                                       overdue: false,
//                                       statusDisplay: 'Planned',
//                                       statusPctDisplay: '0% - Planned',
//                                       statusColor: 'primary',
//                                       priorityDisplay: {
//                                         'id': selectedPriorityValue,
//                                         'value': selectedPriorityValue,
//                                         'color': selectedColor.toString(),
//                                       },
//                                       taskSize: 0,
//                                       completedTaskSize: 0,
//                                       completedTaskHours: 0,
//                                       plannedTaskHours: 0,
//                                       taskStatDTO: null,
//                                     ),
//                                   ));
//                             } else {
//                               context.read<MyJobsBloc>().add(UpdateJob(
//                                     jobid: currentJob.id ?? '',
//                                     payload: {
//                                       "tenantId": deliverable.first.tenantId,
//                                       "doctype": "ProjectJobDTO",
//                                       "id": currentJob.id,
//                                       "workKey": state.projects[index].workKey
//                                           ?.toJson(),
//                                       "createdBy":
//                                           currentUserInfo.userKey.aggregateId,
//                                       "modifiedBy":
//                                           currentUserInfo.userKey.aggregateId,
//                                       "attachments": [],
//                                       "checkinType": null,
//                                       "createdAt":
//                                           DateTime.now().toIso8601String(),
//                                       "modifiedAt":
//                                           DateTime.now().toIso8601String(),
//                                       "completedBy": null,
//                                       "completedAt": null,
//                                       "closedBy": null,
//                                       "closedAt": null,
//                                       "deliverableId": deliverable.first.id,
//                                       "deliverableName": deliverable.first.name,
//                                       "milestoneId": null,
//                                       "milestoneName": null,
//                                       "name": jobName.text,
//                                       "description": htmlDescription,
//                                       "status": currentJob.status,
//                                       "priority": selectedPriorityValue,
//                                       "assignee": currentUserInfo.userKey,
//                                       "creator": currentUserInfo.userKey,
//                                       "unitOfWorks":
//                                           currentJob.unitOfWorks?.toInt() ?? 1,
//                                       "completionPercentage":
//                                           currentJob.completionPercentage,
//                                       "targetStartDate": jobStartDateString,
//                                       "targetEndDate": jobEndDateString,
//                                       "startDate": null,
//                                       "endDate": null,
//                                       "cfPairs": [],
//                                       "initialFlag": null,
//                                       "currentFlag": null,
//                                       "flagId": currentJob.id,
//                                       "tasks": [],
//                                       "myProject": true,
//                                       "myOwn": true,
//                                       "usingDefaultDateRange": true,
//                                       "start": safeStartDate.toIso8601String(),
//                                       "end": safeEndDate.toIso8601String(),
//                                       "expired": false,
//                                       "overdue": false,
//                                       "periodDisplay":
//                                           '${DateFormat('MMM d, yyyy').format(safeStartDate)} - ${DateFormat('MMM d, yyyy').format(safeEndDate)}',
//                                       "statusDisplay": 'Planned',
//                                       "statusPctDisplay":
//                                           '${currentJob.completionPercentage}% - ${currentJob.status}',
//                                       "statusColor": 'primary',
//                                       "priorityDisplay": {
//                                         "id": selectedPriorityValue,
//                                         "value": selectedPriorityValue,
//                                         "color": selectedColor.toString(),
//                                       },
//                                       "taskSize": 0,
//                                       "completedTaskSize": 0,
//                                       "completedTaskHours": 0,
//                                       "plannedTaskHours": 0,
//                                       "taskStatDTO": null,
//                                       "permission": null,
//                                       "drawerMenu": null,
//                                     },
//                                   ));

//                               Navigator.of(dialogContext, rootNavigator: true)
//                                   .pop();
//                             }
//                           }
//                         : null,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }
