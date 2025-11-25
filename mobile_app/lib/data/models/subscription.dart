import 'package:equatable/equatable.dart';
import 'package:mobile_app/data/models/tariff.dart';

class Subscription extends Equatable {
  final int id;
  final String name;
  final String link;
  final String? image;
  final List<Tariff> tariffs;

  const Subscription({
    required this.id,
    required this.name,
    required this.link,
    required this.image,
    required this.tariffs,
  });

  @override
  List<Object?> get props => [id, name, link, image, tariffs];

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'],
      name: json['name'],
      link: json['link'],
      image: json['image'],
      tariffs: (json['tariffs'] as List)
          .map((t) => Tariff.fromJson(t))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'link': link,
      'image': image,
      'tariffs': tariffs.map((t) => t.toJson()).toList(),
    };
  }
}
