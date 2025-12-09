import 'dart:convert';

dynamic parse(dynamic data) {
    if (data is String) {
      try {
        return jsonDecode(data);
      } catch (_) {
        return {};
      }
    }
    return data;
  }