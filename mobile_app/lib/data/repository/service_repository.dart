import 'package:mobile_app/data/api/api_client.dart';
import 'package:mobile_app/data/models/service.dart';

class ServiceRepository {
  final ApiClient api;

  ServiceRepository(this.api);

  Future<List<Service>> getServices(int tariffId) async {
    final response = await api.getServices(tariffId);
    final list = response.data['entities'] as List? ?? [];
    return list.map((e) => Service.fromJson(e)).toList();
  }

  Future<Service> createService(
    int tariffId,
    Service service,
  ) async {
    final response = await api.createService(
      tariffId,
      service.toJson(),
    );
    final json = response.data['entity'];
    return Service.fromJson(json);
  }

  Future<Service> updateService(int id, Service service) async {
    final response = await api.updateService(
      id,
      service.toJson(),
    );
    final json = response.data['entity'];
    return Service.fromJson(json);
  }

  Future<void> deleteService(int id) async {
    await api.deleteService(id);
  }
}
