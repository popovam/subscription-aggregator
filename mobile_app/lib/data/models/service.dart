import 'package:equatable/equatable.dart';

class Service extends Equatable {
  final int id;
  final String name;
  final String value;

  const Service({
    required this.id,
    required this.name,
    required this.value,
  });

  @override
  List<Object?> get props => [id, name, value];

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      name: json['name'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'value': value};
  }
}
