import 'package:equatable/equatable.dart';
import 'package:mobile_app/data/models/service.dart';

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
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      services: (json['services'] as List)
          .map((s) => Service.fromJson(s))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'services': services.map((s) => s.toJson()).toList(),
    };
  }
}
