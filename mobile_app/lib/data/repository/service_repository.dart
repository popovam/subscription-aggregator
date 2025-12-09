import 'package:mobile_app/data/api/api_client.dart';
import 'package:mobile_app/data/models/service.dart';
import 'package:mobile_app/data/repository/parser.dart';

class ServiceRepository {
  final ApiClient api;

  ServiceRepository(this.api);

  Future<List<Service>> getServices(int tariffId) async {
    final response = await api.getServices(tariffId);
    final data = parse(response.data);

    final list = data['entities'] as List? ?? [];
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
    final data = parse(response.data);

    return Service.fromJson(data['entity'] ?? {});
  }

  Future<Service> updateService(int id, Service service) async {
    final response = await api.updateService(
      id,
      service.toJson(),
    );
    final data = parse(response.data);

    return Service.fromJson(data['entity'] ?? {});
  }

  Future<void> deleteService(int id) async {
    await api.deleteService(id);
  }
}
