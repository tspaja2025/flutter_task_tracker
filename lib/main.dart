import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_tracker/providers/auth_mode_provider.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const ProviderScope(child: FlutterTaskTracker()));
}

class FlutterTaskTracker extends StatelessWidget {
  const FlutterTaskTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Task Tracker',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const AuthScreen(),
    );
  }
}

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(authModeProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(authModeProvider.notifier);

    return SizedBox(
      width: 420,
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Sign In",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    "Welcome back to your workspace.",
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 16),
                  const TextField(
                    decoration: InputDecoration(
                      label: Text("Email Address"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const TextField(
                    decoration: InputDecoration(
                      label: Text("Password"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  CheckboxListTile(
                    title: Text(
                      "Stay signed in for 30 days",
                      style: TextStyle(fontSize: 12),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () {
                      context.goNamed("dashboard");
                    },
                    child: const Text("Sign In"),
                  ),
                ],
              ),
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
                child: const Text("Sign Up"),
              ),
            ],
          ),
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
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(authModeProvider.notifier);

    return SizedBox(
      width: 420,
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Sign Up",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    "Experience the flow of professional task management.",
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 16),
                  const TextField(
                    decoration: InputDecoration(
                      label: Text("Email Address"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const TextField(
                    decoration: InputDecoration(
                      label: Text("Password"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const TextField(
                    decoration: InputDecoration(
                      label: Text("Repeat Password"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  CheckboxListTile(
                    title: Text(
                      "Accept Terms of Service and Privacy Policy",
                      style: TextStyle(fontSize: 12),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () {
                      context.goNamed("projects");
                    },
                    child: const Text("Sign Up"),
                  ),
                ],
              ),
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
