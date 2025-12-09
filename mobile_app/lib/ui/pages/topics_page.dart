import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/data/api/api_client.dart';
import 'package:mobile_app/data/repository/topic_repository.dart';
import 'package:mobile_app/logic/topic/topic_bloc.dart';
import 'package:mobile_app/logic/topic/topic_event.dart';
import 'package:mobile_app/logic/topic/topic_state.dart';
import 'package:mobile_app/ui/widgets/bottom_bar.dart';
import 'package:mobile_app/ui/widgets/search_bar.dart';

class TopicsPage extends StatefulWidget {
  const TopicsPage({super.key});

  @override
  State<TopicsPage> createState() => _TopicsPageState();
}

class _TopicsPageState extends State<TopicsPage> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          TopicBloc(TopicRepository(ApiClient()))
            ..add(GetTopics()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Темы"),
          centerTitle: true,
        ),

        bottomNavigationBar: BottomBar(currentIdx: 0),

        body: Column(
          children: [
            AppSearchBar(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),

            Expanded(
              child: BlocBuilder<TopicBloc, TopicState>(
                builder: (context, state) {
                  if (state is TopicLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is TopicError) {
                    return Center(
                      child: Text(
                        "Ошибка: ${state.message}",
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    );
                  }

                  if (state is TopicsLoaded) {
                    final filtered = _filter(state.topics);

                    if (filtered.isEmpty) {
                      return _nothingFound();
                    }

                    return _buildList(filtered);
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List _filter(List topics) {
    if (searchQuery.isEmpty) return topics;

    return topics.where((t) {
      return t.name.toLowerCase().contains(
        searchQuery.toLowerCase(),
      );
    }).toList();
  }

  Widget _nothingFound() {
    return const Center(
      child: Text(
        "Ничего не найдено...",
        style: TextStyle(fontSize: 18, color: Colors.grey),
      ),
    );
  }

  Widget _buildList(List topics) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: topics.length,
      itemBuilder: (_, i) {
        final topic = topics[i];

        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              "/subscriptions",
              arguments: {
                "topicId": topic.id,
                "topicName": topic.name,
              },
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF90CAF9),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.image,
                    color: Colors.white,
                    size: 30,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Text(
                    topic.name,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),

                const Icon(Icons.arrow_forward_ios, size: 18),
              ],
            ),
          ),
        );
      },
    );
  }
}
