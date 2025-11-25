import 'package:equatable/equatable.dart';
import 'package:mobile_app/data/models/service.dart';
import 'package:mobile_app/data/models/subscription.dart';

abstract class SubscriptionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetSubscriptions extends SubscriptionEvent {
  final int topicId;
  final List<Service> filters;

  GetSubscriptions(this.topicId, this.filters);

  @override
  List<Object?> get props => [topicId, filters];
}

class GetSubscriptionById extends SubscriptionEvent {
  final int id;

  GetSubscriptionById(this.id);

  @override
  List<Object?> get props => [id];
}

class CreateSubscription extends SubscriptionEvent {
  final int topicId;
  final Subscription sub;

  CreateSubscription(this.topicId, this.sub);

  @override
  List<Object?> get props => [topicId, sub];
}

class UpdateSubscription extends SubscriptionEvent {
  final int id;
  final Subscription sub;

  UpdateSubscription(this.id, this.sub);

  @override
  List<Object?> get props => [id, sub];
}

class DeleteSubscription extends SubscriptionEvent {
  final int id;
  DeleteSubscription(this.id);

  @override
  List<Object?> get props => [id];
}
