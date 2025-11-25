import 'package:equatable/equatable.dart';
import 'package:mobile_app/data/models/topic.dart';

abstract class TopicState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TopicInitial extends TopicState {}

class TopicLoading extends TopicState {}

class TopicsLoaded extends TopicState {
  final List<Topic> topics;
  TopicsLoaded(this.topics);

  @override
  List<Object?> get props => [topics];
}

class TopicLoaded extends TopicState {
  final Topic topic;
  TopicLoaded(this.topic);

  @override
  List<Object?> get props => [topic];
}

class TopicError extends TopicState {
  final String message;
  TopicError(this.message);

  @override
  List<Object?> get props => [message];
}
