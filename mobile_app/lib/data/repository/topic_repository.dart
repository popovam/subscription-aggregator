import 'parser.dart';
import 'package:mobile_app/data/api/api_client.dart';
import 'package:mobile_app/data/models/topic.dart';

class TopicRepository {
  final ApiClient api;

  TopicRepository(this.api);

  Future<List<Topic>> getTopics() async {
    final response = await api.getTopics();
    final data = parse(response.data);

    final list = data['entities'] as List? ?? [];
    return list.map((e) => Topic.fromJson(e)).toList();
  }

  Future<Topic> getTopic(int id) async {
    final response = await api.getTopic(id);
    final data = parse(response.data);

    final json = data['entity'] ?? {};
    return Topic.fromJson(json);
  }

  Future<Topic> createTopic(Topic topic) async {
    final response = await api.createTopic(topic.toJson());
    final data = parse(response.data);

    final json = data['entity'] ?? {};
    return Topic.fromJson(json);
  }

  Future<Topic> updateTopic(int id, Topic topic) async {
    final response = await api.updateTopic(id, topic.toJson());
    final data = parse(response.data);

    final json = data['entity'] ?? {};
    return Topic.fromJson(json);
  }

  Future<void> deleteTopic(int id) async {
    await api.deleteTopic(id);
  }
}
