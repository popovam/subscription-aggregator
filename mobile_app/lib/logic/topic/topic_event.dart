import 'package:equatable/equatable.dart';
import 'package:mobile_app/data/models/topic.dart';

abstract class TopicEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTopics extends TopicEvent {}

class GetTopicById extends TopicEvent {
  final int id;
  GetTopicById(this.id);

  @override
  List<Object?> get props => [id];
}

class CreateTopic extends TopicEvent {
  final Topic topic;
  CreateTopic(this.topic);

  @override
  List<Object?> get props => [topic];
}

class UpdateTopic extends TopicEvent {
  final int id;
  final Topic topic;
  UpdateTopic(this.id, this.topic);

  @override
  List<Object?> get props => [id, topic];
}

class DeleteTopic extends TopicEvent {
  final int id;
  DeleteTopic(this.id);

  @override
  List<Object?> get props => [id];
}
