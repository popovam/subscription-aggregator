import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/data/repository/topic_repository.dart';
import 'package:mobile_app/logic/topic/topic_event.dart';
import 'package:mobile_app/logic/topic/topic_state.dart';

class TopicBloc extends Bloc<TopicEvent, TopicState> {
  final TopicRepository repo;

  TopicBloc(this.repo) : super(TopicInitial()) {
    on<GetTopics>(_onGetTopics);
    on<GetTopicById>(_onGetTopicsById);
    on<CreateTopic>(_onCreateTopic);
    on<UpdateTopic>(_onUpdateTopic);
    on<DeleteTopic>(_onDeleteTopic);
  }

  Future<void> _onGetTopics(
    GetTopics event,
    Emitter<TopicState> emit,
  ) async {
    emit(TopicLoading());
    try {
      final topics = await repo.getTopics();
      emit(TopicsLoaded(topics));
    } catch (e) {
      emit(TopicError(e.toString()));
    }
  }

  Future<void> _onGetTopicsById(
    GetTopicById event,
    Emitter<TopicState> emit,
  ) async {
    emit(TopicLoading());
    try {
      final topic = await repo.getTopic(event.id);
      emit(TopicLoaded(topic));
    } catch (e) {
      emit(TopicError(e.toString()));
    }
  }

  Future<void> _onCreateTopic(
    CreateTopic event,
    Emitter<TopicState> emit,
  ) async {
    emit(TopicLoading());
    try {
      final topic = await repo.createTopic(event.topic);
      emit(TopicLoaded(topic));
    } catch (e) {
      emit(TopicError(e.toString()));
    }
  }

  Future<void> _onUpdateTopic(
    UpdateTopic event,
    Emitter<TopicState> emit,
  ) async {
    emit(TopicLoading());
    try {
      final topic = await repo.updateTopic(
        event.id,
        event.topic,
      );
      emit(TopicLoaded(topic));
    } catch (e) {
      emit(TopicError(e.toString()));
    }
  }

  Future<void> _onDeleteTopic(
    DeleteTopic event,
    Emitter<TopicState> emit,
  ) async {
    emit(TopicLoading());
    try {
      await repo.deleteTopic(event.id);
      final topics = await repo.getTopics();
      emit(TopicsLoaded(topics));
    } catch (e) {
      emit(TopicError(e.toString()));
    }
  }
}
