import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/data/api/api_client.dart';
import 'package:mobile_app/data/models/service.dart';
import 'package:mobile_app/data/repository/subscription_repository.dart';
import 'package:mobile_app/logic/subscription/subscription_bloc.dart';
import 'package:mobile_app/logic/subscription/subscription_event.dart';
import 'package:mobile_app/logic/subscription/subscription_state.dart';
import 'package:mobile_app/ui/widgets/bottom_bar.dart';
import 'package:mobile_app/ui/widgets/subscription_card.dart';
import 'criteria_page.dart';

class SubscriptionsPage extends StatefulWidget {
  const SubscriptionsPage({super.key});

  @override
  State<SubscriptionsPage> createState() =>
      _SubscriptionsPageState();
}

class _SubscriptionsPageState extends State<SubscriptionsPage> {
  List<Service> selectedServices = [];

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments
            as Map<String, dynamic>;

    final int topicId = args["topicId"];
    final String topicName = args["topicName"];

    return BlocProvider(
      create: (_) =>
          SubscriptionBloc(SubscriptionRepository(ApiClient()))
            ..add(GetSubscriptions(topicId, selectedServices)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(topicName),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        CriteriaPage(topicId: topicId),
                  ),
                );

                if (result != null && result is List<Service>) {
                  setState(() {
                    selectedServices = result;
                  });

                  // повторно загружаем сервисы с фильтрами
                  context.read<SubscriptionBloc>().add(
                    GetSubscriptions(topicId, selectedServices),
                  );
                }
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomBar(currentIdx: 1),

        body: BlocBuilder<SubscriptionBloc, SubscriptionState>(
          builder: (context, state) {
            if (state is SubscriptionLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is SubscriptionError) {
              return Center(
                child: Text(
                  "Ошибка: ${state.message}",
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (state is SubscriptionsLoaded) {
              if (state.subs.isEmpty) {
                return const Center(
                  child: Text(
                    "Нет сервисов по выбранным критериям",
                    style: TextStyle(fontSize: 18),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.subs.length,
                itemBuilder: (_, i) {
                  return SubscriptionCard(
                    subscription: state.subs[i],
                  );
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
