import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppSearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const AppSearchBar({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFB39DDB),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: onChanged,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Поиск...",
                hintStyle: TextStyle(color: Colors.white70),
              ),
            ),
          ),
          const Icon(Icons.search, color: Colors.white),
        ],
      ),
    );
  }
}
