import 'package:equatable/equatable.dart';
import 'package:mobile_app/data/models/tariff.dart';

abstract class TariffEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTariffs extends TariffEvent {
  final int subscriptionId;
  GetTariffs(this.subscriptionId);

  @override
  List<Object?> get props => [subscriptionId];
}

class GetTariffById extends TariffEvent {
  final int id;
  GetTariffById(this.id);

  @override
  List<Object?> get props => [id];
}

class CreateTariff extends TariffEvent {
  final int subscriptionId;
  final Tariff tariff;

  CreateTariff(this.subscriptionId, this.tariff);

  @override
  List<Object?> get props => [subscriptionId, tariff];
}

class UpdateTariff extends TariffEvent {
  final int id;
  final Tariff tariff;

  UpdateTariff(this.id, this.tariff);

  @override
  List<Object?> get props => [id, tariff];
}

class DeleteTariff extends TariffEvent {
  final int id;
  DeleteTariff(this.id);

  @override
  List<Object?> get props => [id];
}
