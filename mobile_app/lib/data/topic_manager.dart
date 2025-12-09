import 'package:mobile_app/data/models/subscription.dart';
import 'package:mobile_app/data/models/service.dart';

class TopicFilterManager {
  static final TopicFilterManager _instance =
      TopicFilterManager._internal();
  factory TopicFilterManager() => _instance;
  TopicFilterManager._internal();

  List<Subscription> _all = [];

  List<Subscription> _filtered = [];

  final Set<String> activeCriteria = {};

  List<Subscription> get current =>
      activeCriteria.isEmpty ? _all : _filtered;

  void setAll(List<Subscription> list) {
    _all = list;
  }

  void apply(List<Service> criteriaList) {
    activeCriteria
      ..clear()
      ..addAll(criteriaList.map((c) => c.key));

    if (activeCriteria.isEmpty) {
      _filtered = [];
      return;
    }

    _filtered = _all.where((sub) {
      final serviceKeys = sub.tariffs
          .expand((t) => t.services)
          .map((s) => s.key)
          .toSet();

      return activeCriteria.every(serviceKeys.contains);
    }).toList();
  }

  void clear() {
    _all = [];
    _filtered = [];
    activeCriteria.clear();
  }
}
