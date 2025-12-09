import 'package:equatable/equatable.dart';
import 'tariff.dart';

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
      id: json['id'] ?? json['Id'] ?? 0,
      name: json['name'] ?? json['Name'] ?? "",
      link: json['link'] ?? json['Link'] ?? "",
      image: json['image'] ?? json['Image'],
      tariffs: (json['tariffs'] ?? json['Tariffs'] ?? [])
          .map<Tariff>((t) => Tariff.fromJson(t))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': link,
      'image': image,
      'tariffs': tariffs.map((s) => s.toJson()).toList(),
    };
  }

  Subscription copyWith({List<Tariff>? tariffs}) {
    return Subscription(
      id: id,
      name: name,
      link: link,
      image: image,
      tariffs: tariffs ?? this.tariffs,
    );
  }
}
