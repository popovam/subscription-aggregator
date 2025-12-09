import 'package:mobile_app/data/api/api_client.dart';
import 'package:mobile_app/data/models/service.dart';
import 'package:mobile_app/data/models/subscription.dart';
import 'package:mobile_app/data/models/tariff.dart';
import 'package:mobile_app/data/repository/parser.dart';

class SubscriptionRepository {
  final ApiClient api;

  SubscriptionRepository(this.api);

  Future<List<Subscription>> getSubscriptions(
    int topicId,
    List<Service> selectedServices,
  ) async {
    final response = await api.getSubscriptions(topicId, []);
    final data = parse(response.data);

    final list = data['entities'] as List? ?? [];
    final subs = list
        .map((e) => Subscription.fromJson(e))
        .toList();

    for (var i = 0; i < subs.length; i++) {
      final sub = subs[i];

      final updatedTariffs = <Tariff>[];

      for (var tariff in sub.tariffs) {
        final servicesResp = await api.getServices(tariff.id);
        final servicesData = parse(servicesResp.data);

        final updatedServices =
            (servicesData["entities"] as List)
                .map((e) => Service.fromJson(e))
                .toList();

        updatedTariffs.add(
          tariff.copyWith(services: updatedServices),
        );
      }

      subs[i] = sub.copyWith(tariffs: updatedTariffs);
    }

    if (selectedServices.isEmpty) {
      return subs;
    }

    final normalizedSelected = selectedServices
        .map((s) => s.key)
        .toSet();

    return subs.where((sub) {
      final allServiceKeys = sub.tariffs
          .expand((t) => t.services)
          .map((s) => s.key)
          .toSet();

      return normalizedSelected.every(allServiceKeys.contains);
    }).toList();
  }

  Future<Subscription> getSubscription(int id) async {
    final response = await api.getSubscription(id);
    final data = parse(response.data);

    return Subscription.fromJson(data['entity'] ?? {});
  }

  Future<Subscription> createSubscription(
    int topicId,
    Subscription sub,
  ) async {
    final response = await api.createSubscription(
      topicId,
      sub.toJson(),
    );
    final data = parse(response.data);

    return Subscription.fromJson(data['entity'] ?? {});
  }

  Future<Subscription> updateSubscription(
    int id,
    Subscription sub,
  ) async {
    final response = await api.updateSubscription(
      id,
      sub.toJson(),
    );
    final data = parse(response.data);

    return Subscription.fromJson(data['entity'] ?? {});
  }

  Future<void> deleteSubscription(int id) async {
    await api.deleteSubscription(id);
  }
}
