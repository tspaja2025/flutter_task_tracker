import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SettingsScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const LogoSection(),
                    const SizedBox(height: 40),
                    const LoginCard(),
                    const SizedBox(height: 24),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(color: Colors.white70),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text("Create an account?"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LogoSection extends StatelessWidget {
  const LogoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: const Color(0xFF5B4CF4),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple.withValues(alpha: 0.5),
                blurRadius: 20,
              ),
            ],
          ),
          child: const Center(
            child: Text(
              "T",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        const Text(
          "TaskTrack",
          style: TextStyle(
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          "Precicion task management for professionals.",
          style: TextStyle(color: Colors.grey.shade500),
        ),
      ],
    );
  }
}

class LoginCard extends StatelessWidget {
  const LoginCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white24),
        gradient: LinearGradient(
          colors: [const Color(0xFF191A22), const Color(0xFF111217)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 40,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Welcome back",
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 30),

          _buildField("EMAIL ADDRESS", Icons.mail_outline, "name@company.com"),

          const SizedBox(height: 20),

          _buildField(
            "PASSWORD",
            Icons.lock_outline,
            "••••••••",
            suffix: Icons.visibility_outlined,
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Checkbox(value: true, onChanged: (_) {}),
              const Text(
                "Stay signed in for 30 days",
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5B4CF4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                "Sign In",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),

          const SizedBox(height: 16),

          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(56),
              side: const BorderSide(color: Colors.white24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text("⚡ QUICK FILL DEMO USER"),
          ),

          const SizedBox(height: 24),

          Row(
            children: const [
              Expanded(child: Divider(color: Colors.white12)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  "OR CONTINUE WITH",
                  style: TextStyle(color: Colors.white38),
                ),
              ),
              Expanded(child: Divider(color: Colors.white12)),
            ],
          ),

          const SizedBox(height: 24),

          Row(
            children: [
              Expanded(child: _socialButton(Icons.g_mobiledata, "Google")),
              const SizedBox(width: 12),
              Expanded(child: _socialButton(Icons.badge_outlined, "SSO Login")),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _socialButton(IconData icon, String text) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon),
      label: Text(text),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(0, 50),
        side: const BorderSide(color: Colors.white12),
      ),
    );
  }

  Widget _buildField(
    String label,
    IconData icon,
    String hint, {
    IconData? suffix,
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
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
            suffixIcon: suffix != null ? Icon(suffix) : null,
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

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const LogoSection(),
                    const SizedBox(height: 40),
                    const RegisterCard(),
                    const SizedBox(height: 24),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(color: Colors.white70),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text("Sign In"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterCard extends StatelessWidget {
  const RegisterCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white24),
        gradient: LinearGradient(
          colors: [const Color(0xFF191A22), const Color(0xFF111217)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 40,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Create your workspace",
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            "Experience the flow of professional task management.",
            style: TextStyle(color: Colors.white38),
          ),

          const SizedBox(height: 30),

          _buildField("EMAIL ADDRESS", Icons.mail_outline, "name@company.com"),

          const SizedBox(height: 20),

          _buildField(
            "PASSWORD",
            Icons.lock_outline,
            "••••••••",
            suffix: Icons.visibility_outlined,
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Checkbox(value: true, onChanged: (_) {}),
              const Text(
                "Terms of Service and Privacy Policy",
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5B4CF4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                "Create Account",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),

          const SizedBox(height: 24),

          Row(
            children: const [
              Expanded(child: Divider(color: Colors.white12)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  "OR CONTINUE WITH",
                  style: TextStyle(color: Colors.white38),
                ),
              ),
              Expanded(child: Divider(color: Colors.white12)),
            ],
          ),

          const SizedBox(height: 24),

          Row(
            children: [
              Expanded(child: _socialButton(Icons.g_mobiledata, "Google")),
              const SizedBox(width: 12),
              Expanded(child: _socialButton(Icons.badge_outlined, "SSO Login")),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _socialButton(IconData icon, String text) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon),
      label: Text(text),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(0, 50),
        side: const BorderSide(color: Colors.white12),
      ),
    );
  }

  Widget _buildField(
    String label,
    IconData icon,
    String hint, {
    IconData? suffix,
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
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
            suffixIcon: suffix != null ? Icon(suffix) : null,
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

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Column(
        children: [
          const TopNavBar(),
          Expanded(
            child: Row(
              children: [
                const Sidebar(),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const DashboardHeader(),

                        const SizedBox(height: 40),

                        Expanded(
                          child: Row(
                            children: const [
                              Expanded(child: KanbanColumn(title: "To Do")),

                              SizedBox(width: 24),

                              Expanded(
                                child: KanbanColumn(title: "In Progress"),
                              ),

                              SizedBox(width: 24),

                              Expanded(child: KanbanColumn(title: "Done")),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      decoration: BoxDecoration(
        color: AppColors.panel,
        border: Border(right: BorderSide(color: AppColors.border)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ListTile(
              selected: true,
              leading: const Icon(Icons.text_snippet),
              title: const Text("Tasks"),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.textPrimary,
                ),
                icon: const Icon(Icons.add),
                label: const Text("New Task"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class KanbanColumn extends StatelessWidget {
  final String title;

  const KanbanColumn({super.key, required this.title});

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
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),

              const Spacer(),

              IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
            ],
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

class TaskCard extends StatelessWidget {
  const TaskCard({super.key});

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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: .15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text("RESEARCH", style: TextStyle(fontSize: 10)),
          ),

          const SizedBox(height: 16),

          const Text(
            "User Persona Analysis",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
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
                  color: Colors.red.withValues(alpha: .15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text("High", style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Project Velocity",
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          "Manage your high-efficiency workflow for the Q4 sprint.",
          style: TextStyle(color: Colors.grey.shade500, fontSize: 18),
        ),
      ],
    );
  }
}

class TopNavBar extends StatefulWidget {
  const TopNavBar({super.key});

  @override
  State<TopNavBar> createState() => _TopNavBarState();
}

class _TopNavBarState extends State<TopNavBar> {
  AnimationStatus _animationStatus = AnimationStatus.dismissed;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.panel,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            const Text(
              "TaskTrack",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 16),
            SizedBox(
              width: 200,
              height: 32,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: AppColors.card,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_outlined,
                color: AppColors.textPrimary,
              ),
            ),
            MenuAnchor(
              animated: true,
              onAnimationStatusChanged: (AnimationStatus status) {
                _animationStatus = status;
              },
              menuChildren: [
                MenuItemButton(
                  child: Text("Settings"),
                ),
                MenuItemButton(
                  child: Text("Sign Out"),
                ),
              ],
              builder:
                  (
                    BuildContext context,
                    MenuController controller,
                    Widget? child,
                  ) {
                    return IconButton(
                      onPressed: () {
                        if (_animationStatus.isForwardOrCompleted) {
                          controller.close();
                        } else {
                          controller.open();
                        }
                      },
                      icon: const Icon(
                        Icons.person_outlined,
                        color: AppColors.textPrimary,
                      ),
                    );
                  },
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Column(
        children: [
          const TopNavBar(),
          Expanded(
            child: Row(
              children: [
                const Sidebar(),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SettingsHeader(),

                        const SizedBox(height: 40),

                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.blue.withValues(alpha: .15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text("RESEARCH", style: TextStyle(fontSize: 10)),
                          ),

                          const SizedBox(height: 16),

                          const Text(
                            "User Persona Analysis",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
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
                                  color: Colors.red.withValues(alpha: .15),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text("High", style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsHeader extends StatelessWidget {
  const SettingsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Settings",
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          "Manage your account preferences and security settings.",
          style: TextStyle(color: Colors.grey.shade500, fontSize: 18),
        ),
      ],
    );
  }
}

class AppColors {
  static const bg = Color(0xFF050505);
  static const panel = Color(0xFF111318);
  static const card = Color(0xFF181A21);
  static const border = Color(0xFF262A34);
  static const primary = Color(0xFF5B4CF4);
  static const success = Color(0xFF00D68F);
  static const warning = Color(0xFFFFB020);
  static const danger = Color(0xFFFF4D67);
  static const textPrimary = Colors.white;
  static const textSecondary = Color(0xFF8C919D);
}
