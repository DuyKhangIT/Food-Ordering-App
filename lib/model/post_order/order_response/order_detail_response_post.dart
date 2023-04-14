class OrderDetailResponse {
  String food = "";
  int quantity = 0;
  String id = "";

  OrderDetailResponse(this.food, this.quantity, this.id);

  factory OrderDetailResponse.fromJson(Map<String, dynamic> json) {
    return OrderDetailResponse(
      json['food'],
      json['quantity'],
      json['id'],
    );
  }
}
