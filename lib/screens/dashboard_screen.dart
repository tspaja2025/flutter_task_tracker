import 'package:flutter/material.dart';
import 'package:flutter_task_tracker/screens/auth_screen.dart';
import 'package:flutter_task_tracker/services/auth_service.dart';
import 'package:flutter_task_tracker/theme/app_colors.dart';
import 'package:intl/intl.dart';

final authService = AuthService();

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();

  Status statusView = Status.pending;
  Priority priorityView = Priority.medium;
  DateTime? selectedDate;

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      _dateController.text = DateFormat("yyyy-MM-dd").format(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: const Text("TaskTrack"),
        backgroundColor: AppColors.panel,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              onPressed: () async {
                await authService.logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthScreen()),
                );
              },
              tooltip: "Sign Out",
              icon: const Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: const [
                  Expanded(child: KanbanColumn(title: "To Do")),

                  SizedBox(width: 24),

                  Expanded(child: KanbanColumn(title: "In Progress")),

                  SizedBox(width: 24),

                  Expanded(child: KanbanColumn(title: "Done")),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            backgroundColor: AppColors.panel,
            title: const Text("Create New Task"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildField(
                  "TASK TITLE",
                  "e.g. API Integration",
                  _titleController,
                ),

                const SizedBox(height: 16),

                _buildField(
                  "DESCRIPTION",
                  "Provide a brief task description...",
                  _descriptionController,
                ),

                const SizedBox(height: 16),

                SegmentedButton<Status>(
                  showSelectedIcon: false,
                  segments: const <ButtonSegment<Status>>[
                    ButtonSegment(
                      value: Status.pending,
                      label: Text("Pending"),
                    ),
                    ButtonSegment(
                      value: Status.inProgress,
                      label: Text("In Progress"),
                    ),
                    ButtonSegment(value: Status.done, label: Text("Done")),
                  ],
                  selected: <Status>{statusView},
                  onSelectionChanged: (Set<Status> newSelection) {
                    setState(() {
                      statusView = newSelection.first;
                    });
                  },
                ),

                const SizedBox(height: 16),

                SegmentedButton<Priority>(
                  showSelectedIcon: false,
                  segments: const <ButtonSegment<Priority>>[
                    ButtonSegment(value: Priority.low, label: Text("Low")),
                    ButtonSegment(
                      value: Priority.medium,
                      label: Text("Medium"),
                    ),
                    ButtonSegment(value: Priority.high, label: Text("High")),
                  ],
                  selected: <Priority>{priorityView},
                  onSelectionChanged: (Set<Priority> newSelection) {
                    setState(() {
                      priorityView = newSelection.first;
                    });
                  },
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller: _dateController,
                  readOnly: true,
                  onTap: _selectDate,
                  decoration: InputDecoration(
                    labelText: "Due Date",
                    filled: true,
                    fillColor: Colors.black,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.check),
                label: const Text("Create"),
              ),
            ],
          ),
        ),
        tooltip: "New Task",
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildField(
    String label,
    String hint,
    TextEditingController controller, {
    bool obscure = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          obscureText: obscure,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.black,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}

class KanbanColumn extends StatefulWidget {
  final String title;

  const KanbanColumn({super.key, required this.title});

  @override
  State<KanbanColumn> createState() => _KanbanColumnState();
}

class _KanbanColumnState extends State<KanbanColumn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.panel,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: ListView(
              children: const [TaskCard(), SizedBox(height: 16), TaskCard()],
            ),
          ),
        ],
      ),
    );
  }
}

class TaskCard extends StatefulWidget {
  const TaskCard({super.key});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  AnimationStatus _animationStatus = AnimationStatus.dismissed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "User Persona Analysis",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              MenuAnchor(
                animated: true,
                onAnimationStatusChanged: (AnimationStatus status) {
                  _animationStatus = status;
                },
                menuChildren: <Widget>[
                  MenuItemButton(onPressed: () {}, child: Text("Edit")),
                  MenuItemButton(onPressed: () {}, child: Text("Delete")),
                ],
                builder:
                    (
                      BuildContext context,
                      MenuController controller,
                      Widget? child,
                    ) {
                      return IconButton(
                        icon: Icon(Icons.more_vert),
                        onPressed: () {
                          if (_animationStatus.isForwardOrCompleted) {
                            controller.close();
                          } else {
                            controller.open();
                          }
                        },
                      );
                    },
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            "Gather qualitative data from stakeholders...",
            style: TextStyle(color: Colors.grey.shade400),
          ),

          const SizedBox(height: 16),

          LinearProgressIndicator(value: .6, backgroundColor: Colors.white10),

          const SizedBox(height: 16),

          Row(
            children: [
              const Icon(Icons.calendar_month, size: 14, color: Colors.grey),

              const SizedBox(width: 6),

              const Text("Oct 24", style: TextStyle(color: Colors.grey)),

              const Spacer(),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.danger.withValues(alpha: .15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "High",
                  style: TextStyle(color: AppColors.danger),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// AppColors: primary, warning, success
enum Status { pending, inProgress, done }

// AppColors: Grey, warning, danger
enum Priority { low, medium, high }
