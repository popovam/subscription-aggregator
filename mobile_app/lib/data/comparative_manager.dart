import 'package:mobile_app/data/models/subscription.dart';

class ComparisonManager {
  static final ComparisonManager _instance =
      ComparisonManager._internal();
  factory ComparisonManager() => _instance;
  ComparisonManager._internal();

  final List<Subscription> _allSelected = [];

  List<Subscription> _filtered = [];

  final Set<String> activeCriteria = {};

  List<Subscription> get selected => activeCriteria.isEmpty
      ? List.unmodifiable(_allSelected)
      : List.unmodifiable(_filtered);

  void add(Subscription s) {
    if (!_allSelected.any((e) => e.id == s.id)) {
      _allSelected.add(s);
    }
  }

  void clear() {
    _allSelected.clear();
    _filtered.clear();
    activeCriteria.clear();
  }

  void applyFilter(Set<String> criteria) {
    activeCriteria
      ..clear()
      ..addAll(criteria);

    if (criteria.isEmpty) {
      _filtered = [];
      return;
    }

    _filtered = _allSelected.where((sub) {
      final tariffServices = sub.tariffs
          .expand((t) => t.services)
          .map((s) => s.name)
          .toSet();
      return criteria.every(tariffServices.contains);
    }).toList();
  }
}
