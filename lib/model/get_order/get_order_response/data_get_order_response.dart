import 'package:th_flutter/model/get_order/get_order_response/response_order_list.dart';

class DataGetOrderResponse {
  ResponseOrderList? responseOrderList;

  DataGetOrderResponse(
    this.responseOrderList,
  );

  DataGetOrderResponse.buildDefault();
  factory DataGetOrderResponse.fromJson(Map<String, dynamic> json) {
    return DataGetOrderResponse(
      (json['orders'] != null)
          ? ResponseOrderList.fromJson(json['orders'])
          : null,
    );
  }
}
