import 'package:flutter_task_tracker/widget/app_bar_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class AppScaffold extends StatefulWidget {
  final Widget child;

  const AppScaffold({super.key, required this.child});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  bool expanded = true;

  NavigationItem _buildButton(String text, IconData icon, String routeName) {
    final isSelected = _isRouteActive(routeName);

    return NavigationItem(
      label: Text(text),
      selectedStyle: const ButtonStyle.primaryIcon(),
      selected: isSelected,
      onChanged: (selected) {
        if (selected) {
          context.goNamed(routeName);
        }
      },
      child: Icon(icon, size: 16),
    );
  }

  NavigationGroup _buildLabel(String label, List<Widget> children) {
    return NavigationGroup(
      labelAlignment: Alignment.centerLeft,
      label: Text(label).semiBold.muted.xSmall,
      children: children,
    );
  }

  bool _isRouteActive(String routeName) {
    final currentRoute = GoRouterState.of(context).name;
    return currentRoute == routeName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      child: Row(
        children: [
          NavigationRail(
            labelType: NavigationLabelType.expanded,
            labelPosition: NavigationLabelPosition.end,
            alignment: NavigationRailAlignment.start,
            expandedSize: 250,
            expanded: expanded,
            header: [
              Builder(
                builder: (context) {
                  return NavigationSlot(
                    leading: IconContainer(
                      backgroundColor: Colors.black,
                      icon: const Icon(
                        LucideIcons.galleryVerticalEnd,
                      ).iconMedium,
                    ),
                    title: const Text("TaskTrack").medium.small,
                    subtitle: const Text("Enterprise").xSmall.normal,
                    onPressed: () {},
                  );
                },
              ),
            ],
            footer: [
              Builder(
                builder: (context) {
                  return NavigationSlot(
                    leading: IconContainer(
                      backgroundColor: Colors.black,
                      icon: const Icon(
                        LucideIcons.galleryVerticalEnd,
                      ).iconMedium,
                    ),
                    title: const Text("tspaja").medium.small,
                    subtitle: const Text("example@example.com").xSmall.normal,
                    trailing: const Icon(LucideIcons.chevronsUpDown).iconSmall,
                    onPressed: () {
                      showDropdown(
                        context: context,
                        anchorAlignment: AlignmentDirectional.centerEnd,
                        alignment: AlignmentDirectional.centerStart,
                        offset: const Offset(16, 0),
                        builder: (context) {
                          return DropdownMenu(
                            children: [
                              MenuButton(
                                leading: const Icon(LucideIcons.settings),
                                child: const Text("Settings"),
                                onPressed: (ctx) {},
                              ),
                              const MenuDivider(),
                              MenuButton(
                                leading: const Icon(LucideIcons.logOut),
                                child: const Text("Log out"),
                                onPressed: (ctx) => context.goNamed("auth"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
            children: [
              // Pages
              _buildLabel("Pages", [
                _buildButton(
                  "Dashboard",
                  LucideIcons.layoutDashboard,
                  "dashboard",
                ),
              ]),
            ],
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8,
                right: 8,
                bottom: 8,
                left: 0,
              ),
              child: Card(
                padding: const EdgeInsets.all(0),
                borderColor: Theme.of(context).colorScheme.border,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBarWidget(
                      onToggleExpanded: () =>
                          setState(() => expanded = !expanded),
                    ),
                    Flexible(child: SingleChildScrollView(child: widget.child)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
