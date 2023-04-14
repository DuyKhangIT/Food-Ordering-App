class OrderDetailRequest {
  String food = "";
  int quantity = 0;

  OrderDetailRequest(this.food, this.quantity);

  Map<String, dynamic> toBodyRequest() => {
        'food': food,
        'quantity': quantity,
      };
}
