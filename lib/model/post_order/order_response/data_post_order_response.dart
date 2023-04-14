import 'order_response.dart';

class DataPostOrderResponse {
  OrderResponse? orderResponse;

  DataPostOrderResponse(
    this.orderResponse,
  );
  DataPostOrderResponse.buildDefault();
  factory DataPostOrderResponse.fromJson(Map<String, dynamic> json) {
    return DataPostOrderResponse(
      (json['order'] != null) ? OrderResponse.fromJson(json['order']) : null,
    );
  }
}
