import 'package:flutter/material.dart';
import 'package:flutter_task_tracker/services/auth_service.dart';

void main() {
  runApp(const FlutterTaskTracker());
}

final authService = AuthService();

class FlutterTaskTracker extends StatelessWidget {
  const FlutterTaskTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Task Tracker',
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
        ),
      ),
      home: const SessionGate(),
    );
  }
}

class SessionGate extends StatefulWidget {
  const SessionGate({super.key});

  @override
  State<SessionGate> createState() => _SessionGateState();
}

class _SessionGateState extends State<SessionGate> {
  bool _isLoading = true;
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    final activeSession = await authService.hasValidSession();
    setState(() {
      _isAuthenticated = activeSession;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.bg,
        body: Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      );
    }
    return _isAuthenticated ? const DashboardScreen() : const LoginScreen();
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showRegisterPage = false;

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
                    showRegisterPage ? const RegisterCard() : const LoginCard(),
                    const SizedBox(height: 24),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          showRegisterPage
                              ? "Already have an account? "
                              : "Don't have an account? ",
                          style: const TextStyle(color: Colors.white70),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              showRegisterPage = !showRegisterPage;
                            });
                          },
                          child: Text(
                            showRegisterPage ? "Sign In" : "Create an account",
                          ),
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
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.5),
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

class LoginCard extends StatefulWidget {
  const LoginCard({super.key});

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void _handleSignIn() async {
    setState(() => _isLoading = true);

    final errorMessage = await authService.login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    setState(() => _isLoading = false);

    if (errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: AppColors.danger,
        ),
      );
    } else {
      // Successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    }
  }

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

          _buildField(
            "EMAIL ADDRESS",
            Icons.mail_outline,
            "name@company.com",
            _emailController,
          ),

          const SizedBox(height: 20),

          _buildField(
            "PASSWORD",
            Icons.lock_outline,
            "••••••••",
            _passwordController,
            obscure: true,
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _handleSignIn,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      "Sign In",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
            ),
          ),

          const SizedBox(height: 16),

          OutlinedButton(
            onPressed: () {
              _emailController.text = "gopher@golang.org";
              _passwordController.text = "supersecurepassword123";
            },
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(56),
              side: const BorderSide(color: Colors.white24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              "⚡ QUICK FILL DEMO USER",
              style: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField(
    String label,
    IconData icon,
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
            prefixIcon: Icon(icon),
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

class RegisterCard extends StatefulWidget {
  const RegisterCard({super.key});

  @override
  State<RegisterCard> createState() => _RegisterCardState();
}

class _RegisterCardState extends State<RegisterCard> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void _handleRegister() async {
    if (_usernameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all inputs."),
          backgroundColor: AppColors.warning,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    final errorMessage = await authService.register(
      _usernameController.text.trim(),
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    setState(() => _isLoading = false);

    if (errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: AppColors.danger,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Account created! Sign in to continue."),
          backgroundColor: AppColors.success,
        ),
      );
      _usernameController.clear();
      _emailController.clear();
      _passwordController.clear();
    }
  }

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
            "Create account",
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 30),

          _buildField(
            "USERNAME",
            Icons.person_outline,
            "gopher123",
            _usernameController,
          ),

          const SizedBox(height: 20),

          _buildField(
            "EMAIL ADDRESS",
            Icons.mail_outline,
            "name@company.com",
            _emailController,
          ),

          const SizedBox(height: 20),

          _buildField(
            "PASSWORD",
            Icons.lock_outline,
            "••••••••",
            _passwordController,
            obscure: true,
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _handleRegister,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      "Create Account",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField(
    String label,
    IconData icon,
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
            prefixIcon: Icon(icon),
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
      appBar: AppBar(
        title: const Text("Dashboard Workspace"),
        backgroundColor: AppColors.panel,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.danger),
            onPressed: () async {
              await authService.logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          "Your secure tasks display layer goes here!",
          style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
        ),
      ),
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

// class DashboardScreen extends StatelessWidget {
//   const DashboardScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.bg,
//       body: Column(
//         children: [
//           const TopNavBar(),
//           Expanded(
//             child: Row(
//               children: [
//                 const Sidebar(),

//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(40),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const DashboardHeader(),

//                         const SizedBox(height: 40),

//                         Expanded(
//                           child: Row(
//                             children: const [
//                               Expanded(child: KanbanColumn(title: "To Do")),

//                               SizedBox(width: 24),

//                               Expanded(
//                                 child: KanbanColumn(title: "In Progress"),
//                               ),

//                               SizedBox(width: 24),

//                               Expanded(child: KanbanColumn(title: "Done")),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class Sidebar extends StatelessWidget {
//   const Sidebar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 240,
//       decoration: BoxDecoration(
//         color: AppColors.panel,
//         border: Border(right: BorderSide(color: AppColors.border)),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             ListTile(
//               selected: true,
//               leading: const Icon(Icons.text_snippet),
//               title: const Text("Tasks"),
//             ),

//             const Spacer(),

//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton.icon(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.primary,
//                   foregroundColor: AppColors.textPrimary,
//                 ),
//                 icon: const Icon(Icons.add),
//                 label: const Text("New Task"),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class KanbanColumn extends StatelessWidget {
//   final String title;

//   const KanbanColumn({super.key, required this.title});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: AppColors.panel,
//         borderRadius: BorderRadius.circular(28),
//         border: Border.all(color: AppColors.border),
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Text(
//                 title,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20,
//                 ),
//               ),

//               const Spacer(),

//               IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
//             ],
//           ),

//           const SizedBox(height: 20),

//           Expanded(
//             child: ListView(
//               children: const [TaskCard(), SizedBox(height: 16), TaskCard()],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class TaskCard extends StatelessWidget {
//   const TaskCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: AppColors.card,
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: AppColors.border),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//             decoration: BoxDecoration(
//               color: Colors.blue.withValues(alpha: .15),
//               borderRadius: BorderRadius.circular(6),
//             ),
//             child: const Text("RESEARCH", style: TextStyle(fontSize: 10)),
//           ),

//           const SizedBox(height: 16),

//           const Text(
//             "User Persona Analysis",
//             style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 18,
//             ),
//           ),

//           const SizedBox(height: 8),

//           Text(
//             "Gather qualitative data from stakeholders...",
//             style: TextStyle(color: Colors.grey.shade400),
//           ),

//           const SizedBox(height: 16),

//           LinearProgressIndicator(value: .6, backgroundColor: Colors.white10),

//           const SizedBox(height: 16),

//           Row(
//             children: [
//               const Icon(Icons.calendar_month, size: 14, color: Colors.grey),

//               const SizedBox(width: 6),

//               const Text("Oct 24", style: TextStyle(color: Colors.grey)),

//               const Spacer(),

//               Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 10,
//                   vertical: 4,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.red.withValues(alpha: .15),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: const Text("High", style: TextStyle(color: Colors.red)),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class DashboardHeader extends StatelessWidget {
//   const DashboardHeader({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "Project Velocity",
//           style: TextStyle(
//             fontSize: 48,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),

//         const SizedBox(height: 10),

//         Text(
//           "Manage your high-efficiency workflow for the Q4 sprint.",
//           style: TextStyle(color: Colors.grey.shade500, fontSize: 18),
//         ),
//       ],
//     );
//   }
// }

// class TopNavBar extends StatefulWidget {
//   const TopNavBar({super.key});

//   @override
//   State<TopNavBar> createState() => _TopNavBarState();
// }

// class _TopNavBarState extends State<TopNavBar> {
//   AnimationStatus _animationStatus = AnimationStatus.dismissed;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 48,
//       decoration: BoxDecoration(
//         color: AppColors.panel,
//         border: Border(bottom: BorderSide(color: AppColors.border)),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Row(
//           children: [
//             const Text(
//               "TaskTrack",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(width: 16),
//             SizedBox(
//               width: 200,
//               height: 32,
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: "Search...",
//                   prefixIcon: Icon(Icons.search),
//                   filled: true,
//                   fillColor: AppColors.card,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(16),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//             ),
//             const Spacer(),
//             IconButton(
//               onPressed: () {},
//               icon: const Icon(
//                 Icons.notifications_outlined,
//                 color: AppColors.textPrimary,
//               ),
//             ),
//             MenuAnchor(
//               animated: true,
//               onAnimationStatusChanged: (AnimationStatus status) {
//                 _animationStatus = status;
//               },
//               menuChildren: [
//                 MenuItemButton(child: Text("Settings")),
//                 MenuItemButton(child: Text("Sign Out")),
//               ],
//               builder:
//                   (
//                     BuildContext context,
//                     MenuController controller,
//                     Widget? child,
//                   ) {
//                     return IconButton(
//                       onPressed: () {
//                         if (_animationStatus.isForwardOrCompleted) {
//                           controller.close();
//                         } else {
//                           controller.open();
//                         }
//                       },
//                       icon: const Icon(
//                         Icons.person_outlined,
//                         color: AppColors.textPrimary,
//                       ),
//                     );
//                   },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SettingsScreen extends StatelessWidget {
//   const SettingsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.bg,
//       body: Column(
//         children: [
//           const TopNavBar(),
//           Expanded(
//             child: Row(
//               children: [
//                 const Sidebar(),

//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(40),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SettingsHeader(),

//                         const SizedBox(height: 40),

//                         Container(
//                           padding: const EdgeInsets.all(18),
//                           decoration: BoxDecoration(
//                             color: AppColors.card,
//                             borderRadius: BorderRadius.circular(18),
//                             border: Border.all(color: AppColors.border),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 8,
//                                   vertical: 4,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: Colors.blue.withValues(alpha: .15),
//                                   borderRadius: BorderRadius.circular(6),
//                                 ),
//                                 child: const Text(
//                                   "RESEARCH",
//                                   style: TextStyle(fontSize: 10),
//                                 ),
//                               ),

//                               const SizedBox(height: 16),

//                               const Text(
//                                 "User Persona Analysis",
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 18,
//                                 ),
//                               ),

//                               const SizedBox(height: 8),

//                               Text(
//                                 "Gather qualitative data from stakeholders...",
//                                 style: TextStyle(color: Colors.grey.shade400),
//                               ),

//                               const SizedBox(height: 16),

//                               LinearProgressIndicator(
//                                 value: .6,
//                                 backgroundColor: Colors.white10,
//                               ),

//                               const SizedBox(height: 16),

//                               Row(
//                                 children: [
//                                   const Icon(
//                                     Icons.calendar_month,
//                                     size: 14,
//                                     color: Colors.grey,
//                                   ),

//                                   const SizedBox(width: 6),

//                                   const Text(
//                                     "Oct 24",
//                                     style: TextStyle(color: Colors.grey),
//                                   ),

//                                   const Spacer(),

//                                   Container(
//                                     padding: const EdgeInsets.symmetric(
//                                       horizontal: 10,
//                                       vertical: 4,
//                                     ),
//                                     decoration: BoxDecoration(
//                                       color: Colors.red.withValues(alpha: .15),
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                     child: const Text(
//                                       "High",
//                                       style: TextStyle(color: Colors.red),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SettingsHeader extends StatelessWidget {
//   const SettingsHeader({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "Settings",
//           style: TextStyle(
//             fontSize: 48,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),

//         const SizedBox(height: 10),

//         Text(
//           "Manage your account preferences and security settings.",
//           style: TextStyle(color: Colors.grey.shade500, fontSize: 18),
//         ),
//       ],
//     );
//   }
// }
