import 'package:flutter/material.dart';
import 'package:mobile_app/data/comparative_manager.dart';
import 'package:mobile_app/data/models/subscription.dart';
import 'package:mobile_app/data/models/tariff.dart';
import 'package:mobile_app/data/models/service.dart';
import 'package:mobile_app/ui/widgets/bottom_bar.dart';

class SubscriptionPage extends StatefulWidget {
  final Subscription subscription;

  const SubscriptionPage({
    super.key,
    required this.subscription,
  });

  @override
  State<SubscriptionPage> createState() =>
      _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  int selectedTariffIndex = 0;

  @override
  @override
  Widget build(BuildContext context) {
    final Subscription sub = widget.subscription;

    final bool hasTariffs = sub.tariffs.isNotEmpty;

    final Tariff? currentTariff = hasTariffs
        ? sub.tariffs[selectedTariffIndex]
        : null;

    return Scaffold(
      appBar: AppBar(title: Text(sub.name), centerTitle: true),
      bottomNavigationBar: BottomBar(currentIdx: 1),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!hasTariffs)
              const Expanded(
                child: Center(
                  child: Text(
                    "Тарифы отсутствуют",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),

            if (hasTariffs) ...[
              SizedBox(
                height: 45,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: sub.tariffs.length,
                  itemBuilder: (_, i) {
                    final selected = i == selectedTariffIndex;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTariffIndex = i;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: selected
                              ? const Color(0xFF90CAF9)
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            sub.tariffs[i].name,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),
              const Text(
                "Информация о сервисе",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              if (currentTariff!.price != null)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Цена:",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Text(
                        "${currentTariff.price} руб./мес.",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 10),

              Expanded(
                child: ListView.builder(
                  itemCount: currentTariff.services.length,
                  itemBuilder: (_, i) {
                    final Service s = currentTariff.services[i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${s.name}:",
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Text(
                            s.value.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],

            const SizedBox(height: 20),
            if (hasTariffs)
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    ComparisonManager().add(sub);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "${sub.name} добавлен в сравнение",
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "Добавить в сравнение",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
