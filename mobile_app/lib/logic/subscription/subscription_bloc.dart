import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/data/repository/subscription_repository.dart';
import 'package:mobile_app/data/topic_manager.dart';
import 'subscription_event.dart';
import 'subscription_state.dart';

class SubscriptionBloc
    extends Bloc<SubscriptionEvent, SubscriptionState> {
  final SubscriptionRepository repo;

  SubscriptionBloc(this.repo) : super(SubscriptionInitial()) {
    on<GetSubscriptions>(_onGetAll);
    on<GetSubscriptionById>(_onGetById);
    on<CreateSubscription>(_onCreate);
    on<UpdateSubscription>(_onUpdate);
    on<DeleteSubscription>(_onDelete);
  }

  Future<void> _onGetAll(
    GetSubscriptions event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(SubscriptionLoading());

    try {
      final items = await repo.getSubscriptions(
        event.topicId,
        [],
      );

      TopicFilterManager().setAll(items);

      emit(SubscriptionsLoaded(TopicFilterManager().current));
    } catch (e) {
      emit(SubscriptionError(e.toString()));
    }
  }

  Future<void> _onGetById(
    GetSubscriptionById event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(SubscriptionLoading());
    try {
      final sub = await repo.getSubscription(event.id);
      emit(SubscriptionLoaded(sub));
    } catch (e) {
      emit(SubscriptionError(e.toString()));
    }
  }

  Future<void> _onCreate(
    CreateSubscription event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(SubscriptionLoading());
    try {
      final sub = await repo.createSubscription(
        event.topicId,
        event.sub,
      );
      emit(SubscriptionLoaded(sub));
    } catch (e) {
      emit(SubscriptionError(e.toString()));
    }
  }

  Future<void> _onUpdate(
    UpdateSubscription event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(SubscriptionLoading());
    try {
      final sub = await repo.updateSubscription(
        event.id,
        event.sub,
      );
      emit(SubscriptionLoaded(sub));
    } catch (e) {
      emit(SubscriptionError(e.toString()));
    }
  }

  Future<void> _onDelete(
    DeleteSubscription event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(SubscriptionLoading());
    try {
      await repo.deleteSubscription(event.id);
      emit(SubscriptionInitial());
    } catch (e) {
      emit(SubscriptionError(e.toString()));
    }
  }
}
