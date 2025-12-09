import 'package:flutter/material.dart';
import 'package:mobile_app/data/api/api_client.dart';
import 'package:mobile_app/data/models/service.dart';
import 'package:mobile_app/data/repository/subscription_repository.dart';

class CriteriaPage extends StatefulWidget {
  final int topicId;
  final List<Service> initiallySelected;
  const CriteriaPage({
    super.key,
    this.initiallySelected = const [],
    required this.topicId,
  });

  @override
  State<CriteriaPage> createState() => _CriteriaPageState();
}

class _CriteriaPageState extends State<CriteriaPage> {
  final Map<String, (Service service, bool selected)> criteria =
      {};
  bool loading = true;

  @override
  void initState() {
    super.initState();
    load();
  }

  String makeKey(Service s) => s.key;

  Future<void> load() async {
    final repo = SubscriptionRepository(ApiClient());
    final subs = await repo.getSubscriptions(widget.topicId, []);

    final Map<String, (Service, bool)> result = {};

    final initially = widget.initiallySelected
        .map((s) => makeKey(s))
        .toSet();

    for (final sub in subs) {
      for (final t in sub.tariffs) {
        for (final s in t.services) {
          final key = makeKey(s);
          final selected = initially.contains(key);

          result[key] = (s, selected);
        }
      }
    }

    criteria
      ..clear()
      ..addAll(result);

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Критерии")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                child: const Text("Сбросить"),
                onPressed: () {
                  setState(() {
                    criteria.updateAll(
                      (key, v) => (v.$1, false),
                    );
                  });

                  Navigator.pop(context, <Service>[]);
                },
              ),
            ),

            Expanded(
              child: ListView(
                children: criteria.entries.map((entry) {
                  final key = entry.key;
                  final service = entry.value.$1;
                  final selected = entry.value.$2;

                  return CheckboxListTile(
                    title: Text(
                      "${service.name}: ${service.value}",
                    ),
                    value: selected,
                    onChanged: (v) {
                      setState(() {
                        criteria[key] = (service, v ?? false);
                      });
                    },
                  );
                }).toList(),
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text("Применить"),
                onPressed: () {
                  final chosen = criteria.values
                      .where((v) => v.$2)
                      .map((v) => v.$1)
                      .toList();

                  Navigator.pop(context, chosen);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
