import 'package:flutter/material.dart';
import 'package:mobile_app/data/api/api_client.dart';
import 'package:mobile_app/data/models/service.dart';
import 'package:mobile_app/data/repository/subscription_repository.dart';

class CriteriaPage extends StatefulWidget {
  final int topicId;
  const CriteriaPage({super.key, required this.topicId});

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

  Future<void> load() async {
    final repo = SubscriptionRepository(ApiClient());
    final subs = await repo.getSubscriptions(widget.topicId, []);

    final Map<String, (Service, bool)> result = {};

    for (final sub in subs) {
      for (final t in sub.tariffs) {
        for (final s in t.services) {
          final key =
              "${normalize(s.name)}::${normalize(s.value)}";
          result[key] = (s, false);
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
      appBar: AppBar(
        title: const Text("Критерии"),
        centerTitle: true,
      ),
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
                onPressed: () {
                  final chosen = criteria.values
                      .where((v) => v.$2)
                      .map((v) => v.$1)
                      .toList();

                  Navigator.pop(context, chosen);
                },
                child: const Text("Применить"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
