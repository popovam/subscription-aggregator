import 'package:mobile_app/data/api/api_client.dart';
import 'package:mobile_app/data/models/tariff.dart';
import 'package:mobile_app/data/repository/parser.dart';

class TariffRepository {
  final ApiClient api;

  TariffRepository(this.api);

  Future<List<Tariff>> getTariffs(int subscriptionId) async {
    final response = await api.getTariffs(subscriptionId);
    final data = parse(response.data);

    final list = data['entities'] as List? ?? [];
    return list.map((e) => Tariff.fromJson(e)).toList();
  }

  Future<Tariff> getTariff(int id) async {
    final response = await api.getTariff(id);
    final data = parse(response.data);

    return Tariff.fromJson(data['entity'] ?? {});
  }

  Future<Tariff> createTariff(
    int subscriptionId,
    Tariff tariff,
  ) async {
    final response = await api.createTariff(
      subscriptionId,
      tariff.toJson(),
    );
    final data = parse(response.data);

    return Tariff.fromJson(data['entity'] ?? {});
  }

  Future<Tariff> updateTariff(int id, Tariff tariff) async {
    final response = await api.updateTariff(id, tariff.toJson());
    final data = parse(response.data);

    return Tariff.fromJson(data['entity'] ?? {});
  }

  Future<void> deleteTariff(int id) async {
    await api.deleteTariff(id);
  }
}
