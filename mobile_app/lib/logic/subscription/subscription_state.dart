import 'package:equatable/equatable.dart';
import 'package:mobile_app/data/models/subscription.dart';

abstract class SubscriptionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubscriptionInitial extends SubscriptionState {}

class SubscriptionLoading extends SubscriptionState {}

class SubscriptionsLoaded extends SubscriptionState {
  final List<Subscription> subs;
  SubscriptionsLoaded(this.subs);

  @override
  List<Object?> get props => [subs];
}

class SubscriptionLoaded extends SubscriptionState {
  final Subscription sub;
  SubscriptionLoaded(this.sub);

  @override
  List<Object?> get props => [sub];
}

class SubscriptionError extends SubscriptionState {
  final String message;
  SubscriptionError(this.message);

  @override
  List<Object?> get props => [message];
}
