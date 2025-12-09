import 'package:equatable/equatable.dart';

String normalizeKey(String name, String value) {
  return "${name.toLowerCase().trim()}::${value.toLowerCase().trim()}";
}

class Service extends Equatable {
  final int id;
  final String name;
  final String value;

  const Service({
    required this.id,
    required this.name,
    required this.value,
  });

  String get key => normalizeKey(name, value);

  @override
  List<Object?> get props => [key];

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'] ?? json['Id'] ?? 0,
      name: json['name'] ?? json['Name'] ?? "",
      value: json['value'] ?? json['Value'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'value': value};
  }

  Map<String, dynamic> toFilterJson() {
    return {"name": name, "value": value};
  }
}
