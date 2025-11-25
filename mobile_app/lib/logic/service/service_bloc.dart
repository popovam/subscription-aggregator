import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/data/repository/service_repository.dart';
import 'service_event.dart';
import 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final ServiceRepository repo;

  ServiceBloc(this.repo) : super(ServiceInitial()) {
    on<GetServices>(_onGetServices);
    on<CreateService>(_onCreateService);
    on<UpdateService>(_onUpdateService);
    on<DeleteService>(_onDeleteService);
  }

  Future<void> _onGetServices(
    GetServices event,
    Emitter<ServiceState> emit,
  ) async {
    emit(ServiceLoading());
    try {
      final services = await repo.getServices(event.tariffId);
      emit(ServicesLoaded(services));
    } catch (e) {
      emit(ServiceError(e.toString()));
    }
  }

  Future<void> _onCreateService(
    CreateService event,
    Emitter<ServiceState> emit,
  ) async {
    emit(ServiceLoading());
    try {
      final service = await repo.createService(
        event.tariffId,
        event.service,
      );
      emit(ServiceLoaded(service));
    } catch (e) {
      emit(ServiceError(e.toString()));
    }
  }

  Future<void> _onUpdateService(
    UpdateService event,
    Emitter<ServiceState> emit,
  ) async {
    emit(ServiceLoading());
    try {
      final updated = await repo.updateService(
        event.id,
        event.service,
      );
      emit(ServiceLoaded(updated));
    } catch (e) {
      emit(ServiceError(e.toString()));
    }
  }

  Future<void> _onDeleteService(
    DeleteService event,
    Emitter<ServiceState> emit,
  ) async {
    emit(ServiceLoading());
    try {
      await repo.deleteService(event.id);
      emit(ServiceInitial());
    } catch (e) {
      emit(ServiceError(e.toString()));
    }
  }
}
