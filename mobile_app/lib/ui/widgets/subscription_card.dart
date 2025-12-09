import 'package:flutter/material.dart';
import 'package:mobile_app/data/models/subscription.dart';

class SubscriptionCard extends StatelessWidget {
  final Subscription subscription;

  const SubscriptionCard({
    super.key,
    required this.subscription,
  });

  @override
  Widget build(BuildContext context) {
    final hasTariffs = subscription.tariffs.isNotEmpty;
    final price = hasTariffs
        ? subscription.tariffs.first.price
        : null;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          "/subscription",
          arguments: {"subscription": subscription},
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subscription.name,
                    style: const TextStyle(fontSize: 18),
                  ),
                  if (price != null)
                    Text(
                      "$price руб./мес.",
                      style: const TextStyle(fontSize: 14),
                    ),
                ],
              ),
            ),

            const Icon(Icons.arrow_forward_ios, size: 18),
          ],
        ),
      ),
    );
  }
}
