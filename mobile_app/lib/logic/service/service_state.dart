import 'package:equatable/equatable.dart';
import 'package:mobile_app/data/models/service.dart';

abstract class ServiceState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServiceInitial extends ServiceState {}

class ServiceLoading extends ServiceState {}

class ServicesLoaded extends ServiceState {
  final List<Service> services;

  ServicesLoaded(this.services);

  @override
  List<Object?> get props => [services];
}

class ServiceLoaded extends ServiceState {
  final Service service;

  ServiceLoaded(this.service);

  @override
  List<Object?> get props => [service];
}

class ServiceError extends ServiceState {
  final String message;

  ServiceError(this.message);

  @override
  List<Object?> get props => [message];
}
