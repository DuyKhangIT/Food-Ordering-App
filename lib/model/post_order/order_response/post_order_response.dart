import 'data_post_order_response.dart';

class PostOrderResponse {
  bool status = false;
  DataPostOrderResponse? dataPostOrderResponse;

  PostOrderResponse(
    this.status,
    this.dataPostOrderResponse,
  );

  PostOrderResponse.buildDefault();

  factory PostOrderResponse.fromJson(Map<String, dynamic> json) {
    return PostOrderResponse(
      json['status'],
      (json['data'] != null)
          ? DataPostOrderResponse.fromJson(json['data'])
          : null,
    );
  }
}
