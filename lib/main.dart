import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_task_tracker/providers/auth_mode_provider.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const ProviderScope(child: FlutterTaskTracker()));
}

class FlutterTaskTracker extends StatelessWidget {
  const FlutterTaskTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadcnApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Task Tracker',
      theme: ThemeData(colorScheme: ColorSchemes.darkNeutral),
      home: const DashboardScreen(),
    );
  }
}

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(authModeProvider);

    return Scaffold(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: Text("T").x2Large.bold,
            ),
            const SizedBox(height: 16),
            const Text(
              "TaskTrack",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const Text("Precision task management for professionals."),
            const SizedBox(height: 16),
            switch (mode) {
              AuthMode.signIn => SignInForm(mode: mode),
              AuthMode.signUp => SignUpForm(mode: mode),
            },
          ],
        ),
      ),
    );
  }
}

class SignInForm extends ConsumerStatefulWidget {
  final AuthMode mode;

  const SignInForm({super.key, required this.mode});

  @override
  ConsumerState<SignInForm> createState() => _SignInForm();
}

class _SignInForm extends ConsumerState<SignInForm> {
  CheckboxState _isChecked = CheckboxState.unchecked;

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(authModeProvider.notifier);

    return SizedBox(
      width: 420,
      child: Column(
        children: [
          Card(
            borderWidth: 2,
            borderColor: Colors.gray,
            borderRadius: BorderRadius.circular(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Welcome back",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 16),
                FormField(
                  key: FormKey(#email),
                  label: Text("Email Address"),
                  child: TextField(
                    placeholder: Text("name@company.com"),
                    features: [
                      InputFeature.leading(Icon(LucideIcons.mail)),
                      InputFeature.clear(
                        visibility: InputFeatureVisibility.textNotEmpty,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                FormField(
                  key: FormKey(#password),
                  label: Text("Password"),
                  child: TextField(
                    placeholder: Text("Password"),
                    features: [
                      InputFeature.leading(Icon(LucideIcons.lock)),
                      InputFeature.clear(
                        visibility: InputFeatureVisibility.textNotEmpty,
                      ),
                      InputFeature.passwordToggle(
                        mode: PasswordPeekMode.toggle,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Checkbox(
                  trailing: Text(
                    "Stay signed in for 30 days",
                    style: TextStyle(fontSize: 12),
                  ),
                  state: _isChecked,
                  onChanged: (value) {
                    setState(() {
                      _isChecked = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  onPressed: () {
                    context.goNamed("dashboard");
                  },
                  alignment: Alignment.center,
                  child: const Text("Sign In"),
                ),
                const SizedBox(height: 16),
                OutlineButton(
                  onPressed: () {},
                  alignment: Alignment.center,
                  child: const Text("Quick fill demo user"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account?"),
              const SizedBox(height: 4),
              TextButton(
                onPressed: () {
                  notifier.setMode(AuthMode.signUp);
                },
                child: const Text("Create an account"),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text("&copy; TASKTRACK. ALL RIGHTS RESERVED.").small.muted,
        ],
      ),
    );
  }
}

class SignUpForm extends ConsumerStatefulWidget {
  final AuthMode mode;

  const SignUpForm({super.key, required this.mode});

  @override
  ConsumerState<SignUpForm> createState() => _SignUpForm();
}

class _SignUpForm extends ConsumerState<SignUpForm> {
  CheckboxState _isChecked = CheckboxState.unchecked;

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(authModeProvider.notifier);

    return SizedBox(
      width: 420,
      child: Column(
        children: [
          Card(
            borderWidth: 2,
            borderColor: Colors.gray,
            borderRadius: BorderRadius.circular(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Create your workspace",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  "Experience the flow of professional task management.",
                  style: TextStyle(fontSize: 12, color: Colors.gray[600]),
                ),
                const SizedBox(height: 16),
                FormField(
                  key: FormKey(#fullName),
                  label: Text("Full Name"),
                  child: TextField(placeholder: Text("John Doe")),
                ),
                const SizedBox(height: 16),
                FormField(
                  key: FormKey(#emailAddress),
                  label: Text("Email Address"),
                  child: TextField(placeholder: Text("name@company.com")),
                ),
                const SizedBox(height: 16),
                FormField(
                  key: FormKey(#password),
                  label: Text("Password"),
                  child: TextField(placeholder: Text("Min. 8 characters")),
                ),
                const SizedBox(height: 16),
                Checkbox(
                  trailing: Text(
                    "I agree to the Terms of Service and Privacy Policy",
                    style: TextStyle(fontSize: 12),
                  ),
                  state: _isChecked,
                  onChanged: (value) {
                    setState(() {
                      _isChecked = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  onPressed: () {
                    context.goNamed("projects");
                  },
                  alignment: Alignment.center,
                  child: const Text("Create Account"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an account?"),
              const SizedBox(height: 4),
              TextButton(
                onPressed: () {
                  notifier.setMode(AuthMode.signIn);
                },
                child: const Text("Sign In"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool expanded = true;
  String selected = "Home";

  NavigationItem buildButton(String text, IconData icon) {
    return NavigationItem(
      label: Text(text),
      // alignment: Alignment.centerLeft,
      selectedStyle: const ButtonStyle.primaryIcon(),
      selected: selected == text,
      onChanged: (selected) {
        if (selected) {
          setState(() {
            this.selected = text;
          });
        }
      },
      child: Icon(icon),
    );
  }

  NavigationGroup buildLabel(String label, List<Widget> children) {
    return NavigationGroup(
      labelAlignment: Alignment.centerLeft,
      label: Text(label).semiBold.muted.xSmall,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: [
        AppBar(
          backgroundColor: Theme.of(
            context,
          ).colorScheme.accent.withValues(alpha: 0.4),
          leading: [
            Text("TaskTrack"),
            const SizedBox(width: 8),
            SizedBox(
              width: 200,
              child: TextField(
                placeholder: Text("Search..."),
                features: [
                  InputFeature.leading(
                    StatedWidget.builder(
                      builder: (context, states) {
                        if (states.hovered) {
                          return const Icon(Icons.search);
                        } else {
                          return const Icon(Icons.search).iconMutedForeground();
                        }
                      },
                    ),
                    visibility: InputFeatureVisibility.textEmpty,
                  ),
                  InputFeature.clear(
                    visibility:
                        (InputFeatureVisibility.textNotEmpty &
                            InputFeatureVisibility.focused) |
                        InputFeatureVisibility.hovered,
                  ),
                ],
              ),
            ),
          ],
          trailing: [
            IconButton.ghost(onPressed: () {}, icon: Icon(LucideIcons.bell)),
          ],
        ),
        const Divider(),
      ],
      child: Row(
        children: [
          NavigationRail(
            backgroundColor: Theme.of(
              context,
            ).colorScheme.accent.withValues(alpha: 0.4),
            labelType: NavigationLabelType.expanded,
            labelPosition: NavigationLabelPosition.end,
            alignment: NavigationRailAlignment.start,
            expandedSize: 250,
            expanded: expanded,
            footer: [
              PrimaryButton(
                onPressed: () {},
                alignment: Alignment.center,
                child: const Text("New Task"),
              ),
            ],
            children: [
              buildLabel("Workspace", [
                buildButton("Tasks", LucideIcons.clipboardList),
              ]),
            ],
          ),
          const VerticalDivider(),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TaskScreen(),
            ),
          ),
        ],
      ),
    );
  }
}

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Project Velocity").x2Large.bold,
        const Text(
          "Manage your high-efficiency workflow for the Q4 sprint.",
        ).muted,
        const SizedBox(height: 16),
        Row(
          children: [
            TaskColumn(
              title: "To Do",
              children: [
                TaskCard(
                  title: "User Persona Analysis",
                  tag: "Research",
                  description:
                      "Gather qualitative data from stakeholder interviews and support tickets to define our core client personas.",
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class TaskColumn extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const TaskColumn({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 420,
      child: Card(
        filled: true,
        fillColor: Theme.of(context).colorScheme.accent.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(title), const SizedBox(height: 16), ...children],
        ),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final String tag;

  const TaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      filled: true,
      fillColor: Theme.of(context).colorScheme.accent.withValues(alpha: 0.6),
      borderRadius: BorderRadius.circular(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimaryBadge(child: Text(tag)),
          const SizedBox(height: 8),
          Text(title).large.bold,
          Text(description),
        ],
      ),
    );
  }
}
