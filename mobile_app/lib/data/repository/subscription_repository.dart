import 'package:mobile_app/data/api/api_client.dart';
import 'package:mobile_app/data/models/service.dart';
import 'package:mobile_app/data/models/subscription.dart';

class SubscriptionRepository {
  final ApiClient api;

  SubscriptionRepository(this.api);

  Future<List<Subscription>> getSubscriptions(
    int topicId,
    List<Service> selectedServices,
  ) async {
    final serviceDtos = selectedServices
        .map((s) => s.toJson())
        .toList();
    final response = await api.getSubscriptions(
      topicId,
      serviceDtos,
    );
    final list = response.data['entities'] as List? ?? [];
    return list.map((e) => Subscription.fromJson(e)).toList();
  }

  Future<Subscription> getSubscription(int id) async {
    final response = await api.getSubscription(id);
    final json = response.data['entity'];
    return Subscription.fromJson(json);
  }

  Future<Subscription> createSubscription(
    int topicId,
    Subscription sub,
  ) async {
    final response = await api.createSubscription(
      topicId,
      sub.toJson(),
    );
    final json = response.data['entity'];
    return Subscription.fromJson(json);
  }

  Future<Subscription> updateSubscription(
    int id,
    Subscription sub,
  ) async {
    final response = await api.updateSubscription(
      id,
      sub.toJson(),
    );
    final json = response.data['entity'];
    return Subscription.fromJson(json);
  }

  Future<void> deleteSubscription(int id) async {
    await api.deleteSubscription(id);
  }
}
