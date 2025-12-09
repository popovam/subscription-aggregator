import 'package:flutter/material.dart';
import 'package:mobile_app/ui/pages/comparative_criteria_page.dart';
import 'package:mobile_app/ui/pages/comparative_page.dart';
import 'package:mobile_app/ui/pages/criteria_page.dart';
import 'package:mobile_app/ui/pages/subscription_page.dart';
import 'package:mobile_app/ui/pages/subscriptions_page.dart';
import 'package:mobile_app/ui/pages/topics_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Агрегатор сервисов по подписке",
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const TopicsPage(),

      routes: {
        "/subscriptions": (context) => const SubscriptionsPage(),
        "/subscription": (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>;

          return SubscriptionPage(
            subscription: args["subscription"],
          );
        },
        "/criteria": (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>;
          return CriteriaPage(topicId: args["topicId"]);
        },
        "/table": (context) => ComparisonPage(),
        "/table_criteria": (context) => ComparisonCriteriaPage(),
      },
    );
  }
}
