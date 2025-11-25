import 'package:equatable/equatable.dart';
import 'package:mobile_app/data/models/service.dart';

abstract class ServiceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetServices extends ServiceEvent {
  final int tariffId;
  GetServices(this.tariffId);

  @override
  List<Object?> get props => [tariffId];
}

class CreateService extends ServiceEvent {
  final int tariffId;
  final Service service;

  CreateService(this.tariffId, this.service);

  @override
  List<Object?> get props => [tariffId, service];
}

class UpdateService extends ServiceEvent {
  final int id;
  final Service service;
  UpdateService(this.id, this.service);

  @override
  List<Object?> get props => [id, service];
}

class DeleteService extends ServiceEvent {
  final int id;
  DeleteService(this.id);

  @override
  List<Object?> get props => [id];
}
