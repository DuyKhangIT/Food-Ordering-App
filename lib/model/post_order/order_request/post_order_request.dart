import 'order_detail_request.dart';

class PostOrderRequest{
  String userName = "";
  int total = 0;
  List<OrderDetailRequest>? orderDetail;

  PostOrderRequest(this.userName, this.total,this.orderDetail);

  Map<String, dynamic> toBodyRequest() => {
    'username': userName,
    'total': total,
    'orderDetail': orderDetail,
  };
}