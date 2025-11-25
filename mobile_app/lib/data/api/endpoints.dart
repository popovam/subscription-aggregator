class Endpoints {
  static const String baseUrl = "http://192.168.0.39:5208";

  //
  // Темы
  //
  static const String topicsCreate = "/api/topics/new";
  static const String topicsAll = "/api/topics/all";
  static String topicById(int id) => "/api/topics/$id";
  static String topicsUpdate(int id) => "/api/topics/$id";
  static String topicsDelete(int id) => "/api/topics/$id";

  //
  // Сервисы
  //
  static const String subscriptionsCreate =
      "/api/subscriptions/new";
  static String subscriptionsAll(int topicId) =>
      "/api/subscriptions/$topicId/all";
  static String subscriptionsById(int id) =>
      "/api/subscriptions/$id";
  static String subscriptionsUpdate(int id) =>
      "/api/subscriptions/$id";
  static String subscriptionsDelete(int id) =>
      "/api/subscriptions/$id";

  //
  // Тарифы
  //
  static const String tariffsCreate = "/api/tariffs/new";
  static String tariffsAll(int subscriptionId) =>
      "/api/tariffs/all?subscriptionId=$subscriptionId";
  static String tariffsById(int id) => "/api/tariffs/$id";
  static String tariffsUpdate(int id) => "/api/tariffs/$id";
  static String tariffsDelete(int id) => "/api/tariffs/$id";

  //
  // Услуги
  //
  static const String servicesCreate = "/api/services/new";
  static String servicesAll(int tariffId) =>
      "/api/services/all?tariffId=$tariffId";
  static String servicesUpdate(int id) => "/api/services/$id";
  static String servicesDelete(int id) => "/api/services/$id";
}
