import 'package:equatable/equatable.dart';
import 'package:mobile_app/data/models/tariff.dart';

abstract class TariffState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TariffInitial extends TariffState {}

class TariffLoading extends TariffState {}

class TariffsLoaded extends TariffState {
  final List<Tariff> tariffs;

  TariffsLoaded(this.tariffs);

  @override
  List<Object?> get props => [tariffs];
}

class TariffLoaded extends TariffState {
  final Tariff tariff;

  TariffLoaded(this.tariff);

  @override
  List<Object?> get props => [tariff];
}

class TariffError extends TariffState {
  final String message;

  TariffError(this.message);

  @override
  List<Object?> get props => [message];
}
