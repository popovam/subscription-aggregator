import 'package:flutter/material.dart';
import 'package:mobile_app/data/api/api_client.dart';
import 'package:mobile_app/data/comparative_manager.dart';
import 'package:mobile_app/data/models/service.dart';
import 'package:mobile_app/data/repository/service_repository.dart';
import 'package:mobile_app/ui/pages/comparative_criteria_page.dart';

class ComparisonPage extends StatefulWidget {
  const ComparisonPage({super.key});

  @override
  _ComparisonPageState createState() => _ComparisonPageState();
}

class _ComparisonPageState extends State<ComparisonPage> {
  Map<int, List<Service>> servicesBySubscription = {};
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadServices();
  }

  Future<void> _loadServices() async {
    final selected = ComparisonManager().selected;
    final repo = ServiceRepository(ApiClient());

    for (var sub in selected) {
      final allServices = <Service>[];

      for (var tariff in sub.tariffs) {
        final services = await repo.getServices(tariff.id);

        for (var s in services) {
          if (!allServices.any((x) => x.name == s.name)) {
            allServices.add(s);
          }
        }
      }

      servicesBySubscription[sub.id] = allServices;
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final selected = ComparisonManager().selected;

    if (loading) {
      return Scaffold(
        appBar: AppBar(title: Text("Сравнение")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (selected.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text("Сравнение")),
        body: Center(child: Text("Вы ещё не добавили сервисы")),
      );
    }

    final criteria = <String>{};
    for (var list in servicesBySubscription.values) {
      for (var s in list) {
        criteria.add(s.name);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Сравнительная таблица"),
        leading: IconButton(
          icon: Icon(Icons.list),
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ComparisonCriteriaPage(),
              ),
            );

            if (result == true) {
              setState(() {});
            }
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "В сравнении: ${selected.length}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  const DataColumn(label: Text("Критерии")),
                  for (var sub in selected)
                    DataColumn(label: Text(sub.name)),
                ],
                rows: criteria.map((criterion) {
                  return DataRow(
                    cells: [
                      DataCell(Text(criterion)),
                      for (var sub in selected)
                        DataCell(
                          Text(_valueFor(sub.id, criterion)),
                        ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _valueFor(int subscriptionId, String criterion) {
    final list = servicesBySubscription[subscriptionId] ?? [];

    final found = list.where((s) => s.name == criterion);
    if (found.isEmpty) return "-";

    return found.first.value.isEmpty ? "+" : found.first.value;
  }
}
