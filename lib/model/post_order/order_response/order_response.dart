import 'order_detail_response_post.dart';

class OrderResponse {
  String userName = "";
  int total = 0;
  String createOnDate = "";
  List<OrderDetailResponse>? orderDetailResponse;
  String idOrder = "";

  OrderResponse(this.userName, this.createOnDate, this.total,
      this.orderDetailResponse, this.idOrder);

  OrderResponse.buildDefault();
  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    List<OrderDetailResponse> orderDetailResponse = [];
    if (json['orderDetail'] != null) {
      List<dynamic> arrData = json['orderDetail'];
      for (var i = 0; i < arrData.length; i++) {
        orderDetailResponse.add(
            OrderDetailResponse.fromJson(arrData[i] as Map<String, dynamic>));
      }
    }
    return OrderResponse(
      json['username'],
      json['total'],
      json['createOnDate'],
      orderDetailResponse,
      json['_id'],
    );
  }
}
