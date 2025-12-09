import 'package:flutter/material.dart';
import 'package:mobile_app/data/comparative_manager.dart';

class ComparisonCriteriaPage extends StatefulWidget {
  const ComparisonCriteriaPage({super.key});

  @override
  State<ComparisonCriteriaPage> createState() =>
      _ComparisonCriteriaPageState();
}

class _ComparisonCriteriaPageState
    extends State<ComparisonCriteriaPage> {
  final Set<String> selectedCriteria = {};
  late final List<String> allCriteria;

  @override
  void initState() {
    super.initState();

    final manager = ComparisonManager();

    selectedCriteria.addAll(manager.activeCriteria);

    final subs = manager.selected;
    final Set<String> names = {};

    for (var sub in subs) {
      for (var tariff in sub.tariffs) {
        for (var s in tariff.services) {
          names.add(s.name);
        }
      }
    }

    allCriteria = names.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Критерии")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  for (var c in allCriteria)
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          c,
                          style: const TextStyle(fontSize: 16),
                        ),
                        Checkbox(
                          value: selectedCriteria.contains(c),
                          onChanged: (v) {
                            setState(() {
                              if (v == true) {
                                selectedCriteria.add(c);
                              } else {
                                selectedCriteria.remove(c);
                              }
                            });
                          },
                        ),
                      ],
                    ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: const Text("Сбросить"),
                  onPressed: () {
                    setState(() => selectedCriteria.clear());
                  },
                ),
                TextButton(
                  child: const Text("Очистить таблицу"),
                  onPressed: () {
                    ComparisonManager().clear();
                    Navigator.pop(context, true);
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _applyCriteria,
                child: const Text("Применить"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _applyCriteria() {
    final manager = ComparisonManager();
    manager.applyFilter(selectedCriteria);

    Navigator.pop(context, true);
  }
}
