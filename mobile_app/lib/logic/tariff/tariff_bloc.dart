import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/data/repository/tariff_repository.dart';
import 'tariff_event.dart';
import 'tariff_state.dart';

class TariffBloc extends Bloc<TariffEvent, TariffState> {
  final TariffRepository repo;

  TariffBloc(this.repo) : super(TariffInitial()) {
    on<GetTariffs>(_onGetTariffs);
    on<GetTariffById>(_onGetTariffById);
    on<CreateTariff>(_onCreateTariff);
    on<UpdateTariff>(_onUpdateTariff);
    on<DeleteTariff>(_onDeleteTariff);
  }

  Future<void> _onGetTariffs(
    GetTariffs event,
    Emitter<TariffState> emit,
  ) async {
    emit(TariffLoading());
    try {
      final tariffs = await repo.getTariffs(
        event.subscriptionId,
      );
      emit(TariffsLoaded(tariffs));
    } catch (e) {
      emit(TariffError(e.toString()));
    }
  }

  Future<void> _onGetTariffById(
    GetTariffById event,
    Emitter<TariffState> emit,
  ) async {
    emit(TariffLoading());
    try {
      final tariff = await repo.getTariff(event.id);
      emit(TariffLoaded(tariff));
    } catch (e) {
      emit(TariffError(e.toString()));
    }
  }

  Future<void> _onCreateTariff(
    CreateTariff event,
    Emitter<TariffState> emit,
  ) async {
    emit(TariffLoading());
    try {
      final tariff = await repo.createTariff(
        event.subscriptionId,
        event.tariff,
      );
      emit(TariffLoaded(tariff));
    } catch (e) {
      emit(TariffError(e.toString()));
    }
  }

  Future<void> _onUpdateTariff(
    UpdateTariff event,
    Emitter<TariffState> emit,
  ) async {
    emit(TariffLoading());
    try {
      final tariff = await repo.updateTariff(
        event.id,
        event.tariff,
      );
      emit(TariffLoaded(tariff));
    } catch (e) {
      emit(TariffError(e.toString()));
    }
  }

  Future<void> _onDeleteTariff(
    DeleteTariff event,
    Emitter<TariffState> emit,
  ) async {
    emit(TariffLoading());
    try {
      await repo.deleteTariff(event.id);
      emit(TariffInitial());
    } catch (e) {
      emit(TariffError(e.toString()));
    }
  }
}
