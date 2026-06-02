import 'package:shadcn_flutter/shadcn_flutter.dart';

class AppBarWidget extends StatelessWidget {
  final VoidCallback onToggleExpanded;

  const AppBarWidget({super.key, required this.onToggleExpanded});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).colorScheme.border),
        ),
      ),
      child: Row(
        spacing: 8,
        children: [
          IconButton.ghost(
            onPressed: onToggleExpanded,
            icon: const Icon(LucideIcons.panelLeft, size: 16),
          ),
          const SizedBox(height: 16, child: VerticalDivider()),
          const Spacer(),
          SizedBox(
            width: 200,
            child: TextField(
              placeholder: Text("Search"),
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
      ),
    );
  }
}
