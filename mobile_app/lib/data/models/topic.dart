import 'package:equatable/equatable.dart';
import 'package:mobile_app/data/models/subscription.dart';

class Topic extends Equatable {
  final int id;
  final String name;
  final double rating;
  final String? image;
  final List<Subscription> subscriptions;

  const Topic({
    required this.id,
    required this.name,
    required this.rating,
    required this.image,
    required this.subscriptions,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    rating,
    image,
    subscriptions,
  ];

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json['id'] ?? json['Id'] ?? 0,
      name: json['name'] ?? json['Name'] ?? "",
      rating: (json['rating'] ?? 0).toDouble(),
      image: json['image'] ?? json['Image'],
      subscriptions:
          (json['subscriptions'] ?? json['Subscriptions'] ?? [])
              .map<Subscription>((s) => Subscription.fromJson(s))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'rating': rating,
      'image': image,
      'subscriptions': subscriptions
          .map((s) => s.toJson())
          .toList(),
    };
  }
}
