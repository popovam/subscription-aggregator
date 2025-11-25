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
      id: json['id'],
      name: json['name'],
      rating: (json['rating'] as num).toDouble(),
      image: json['image'],
      subscriptions: (json['subscriptions'] as List)
          .map((s) => Subscription.fromJson(s))
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
