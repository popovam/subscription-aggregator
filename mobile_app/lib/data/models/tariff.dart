import 'package:equatable/equatable.dart';
import 'service.dart';

class Tariff extends Equatable {
  final int id;
  final String name;
  final double price;
  final List<Service> services;

  const Tariff({
    required this.id,
    required this.name,
    required this.price,
    required this.services,
  });

  @override
  List<Object?> get props => [id, name, price, services];

  factory Tariff.fromJson(Map<String, dynamic> json) {
    return Tariff(
      id: json['id'] ?? json['Id'] ?? 0,
      name: json['name'] ?? json['Name'] ?? "",
      price: (json['price'] ?? json['Price'] ?? 0).toDouble(),
      services: (json['services'] ?? json['Services'] ?? [])
          .map<Service>((s) => Service.fromJson(s))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'services': services.map((s) => s.toFilterJson()).toList(),
    };
  }

  Tariff copyWith({List<Service>? services}) {
    return Tariff(
      id: id,
      name: name,
      price: price,
      services: services ?? this.services,
    );
  }
}
