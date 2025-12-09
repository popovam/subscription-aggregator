import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BottomBar extends StatelessWidget {
  final int currentIdx;
  final int? lastTopicId;
  final void Function(int)? onChanged;

  const BottomBar({
    super.key,
    required this.currentIdx,
    this.lastTopicId,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFFB39DDB),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      currentIndex: currentIdx,
      onTap: (i) {
        if (onChanged != null) onChanged!(i);

        switch (i) {
          case 0:
            Navigator.pushNamed(context, "/");
            break;
          case 1:
            if (lastTopicId != null) {
              Navigator.pushNamed(
                context,
                "/subscriptions",
                arguments: lastTopicId,
              );
            }
            break;
          case 2:
            Navigator.pushNamed(context, "/table");
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag_outlined),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart_outlined),
          label: "",
        ),
      ],
    );
  }
}
