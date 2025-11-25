import 'package:dio/dio.dart';
import 'package:mobile_app/data/api/endpoints.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: Endpoints.baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      ),
    );
  }

  //
  // Темы
  //
  Future<Response> getTopics() {
    return _dio.get(Endpoints.topicsAll);
  }

  Future<Response> getTopic(int id) {
    return _dio.get(Endpoints.topicById(id));
  }

  Future<Response> createTopic(Map<String, dynamic> body) {
    return _dio.post(Endpoints.topicsCreate, data: body);
  }

  Future<Response> updateTopic(
    int id,
    Map<String, dynamic> body,
  ) {
    return _dio.put(Endpoints.topicsUpdate(id), data: body);
  }

  Future<Response> deleteTopic(int id) {
    return _dio.delete(Endpoints.topicsDelete(id));
  }

  //
  // Сервисы
  //
  Future<Response> createSubscription(
    int topicId,
    Map<String, dynamic> body,
  ) {
    return _dio.post(
      "${Endpoints.subscriptionsCreate}?topicId=$topicId",
      data: body,
    );
  }

  Future<Response> getSubscriptions(
    int topicId,
    List<Map<String, dynamic>> services,
  ) {
    return _dio.post(
      Endpoints.subscriptionsAll(topicId),
      data: services,
    );
  }

  Future<Response> getSubscription(int id) {
    return _dio.get(Endpoints.subscriptionsById(id));
  }

  Future<Response> updateSubscription(
    int id,
    Map<String, dynamic> body,
  ) {
    return _dio.put(
      Endpoints.subscriptionsUpdate(id),
      data: body,
    );
  }

  Future<Response> deleteSubscription(int id) {
    return _dio.delete(Endpoints.subscriptionsDelete(id));
  }

  //
  // Тарифы
  //
  Future<Response> getTariffs(int subscriptionId) {
    return _dio.get(Endpoints.tariffsAll(subscriptionId));
  }

  Future<Response> getTariff(int id) {
    return _dio.get(Endpoints.tariffsById(id));
  }

  Future<Response> createTariff(
    int subscriptionId,
    Map<String, dynamic> body,
  ) {
    return _dio.post(
      "${Endpoints.tariffsCreate}?subscriptionId=$subscriptionId",
      data: body,
    );
  }

  Future<Response> updateTariff(
    int id,
    Map<String, dynamic> body,
  ) {
    return _dio.put(Endpoints.tariffsUpdate(id), data: body);
  }

  Future<Response> deleteTariff(int id) {
    return _dio.delete(Endpoints.tariffsDelete(id));
  }

  //
  // Услуги
  //
  Future<Response> getServices(int tariffId) {
    return _dio.get(Endpoints.servicesAll(tariffId));
  }

  Future<Response> createService(
    int tariffId,
    Map<String, dynamic> body,
  ) {
    return _dio.post(
      "${Endpoints.servicesCreate}?tariffId=$tariffId",
      data: body,
    );
  }

  Future<Response> updateService(
    int id,
    Map<String, dynamic> body,
  ) {
    return _dio.put(Endpoints.servicesUpdate(id), data: body);
  }

  Future<Response> deleteService(int id) {
    return _dio.delete(Endpoints.servicesDelete(id));
  }
}
