import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:th_flutter/model/check_out_order/checkout_order_request.dart';
import 'package:th_flutter/model/check_out_order/checkout_order_response.dart';
import 'package:th_flutter/model/remove_item_order/remove_item_order_request.dart';
import 'package:th_flutter/model/remove_item_order/remove_item_order_response.dart';
import 'package:th_flutter/model/sum_order/sum_order_request.dart';
import 'package:th_flutter/model/sum_order/sum_order_response.dart';

import '../../handle_api/handle_api.dart';
import '../../model/get_order/get_order_response/order_detail_response_get.dart';
import '../../util/global.dart';

import '../../util/show_loading_dialog.dart';
import '../home/home_page.dart';

class CartPage extends StatefulWidget {
  static String routeName = "/cart_screen";
  final List<OrderDetailResponseGet>? dataOrder;
  const CartPage({Key? key, required this.dataOrder}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<OrderDetailResponseGet>? listDataOrder;
  bool isLoading = false;
  @override
  void initState() {
    listDataOrder = widget.dataOrder;
    super.initState();
  }

  /// call api remove item order
  Future<RemoveItemOrderResponse> removeItemOrderApi(
      RemoveItemOrderRequest removeItemOrderRequest) async {
    setState(() {
      isLoading = true;
      if (isLoading) {
        IsShowDialog().showLoadingDialog(context);
      } else {
        Navigator.of(context).pop();
      }
    });
    RemoveItemOrderResponse removeItemOrderResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse(
              "http://14.225.204.248:7070/api/order/remove-item"),
          RequestType.post,
          headers: null,
          body: const JsonEncoder()
              .convert(removeItemOrderRequest.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to remove item order $error");
      rethrow;
    }
    if (body == null) return RemoveItemOrderResponse.buildDefault();
    removeItemOrderResponse = RemoveItemOrderResponse.fromJson(body);
    if (removeItemOrderResponse.status == false) {
      setState(() {
        isLoading = false;
        if (isLoading) {
          IsShowDialog().showLoadingDialog(context);
        } else {
          Navigator.of(context).pop();
        }
        Fluttertoast.showToast(
            msg: "Remove item fail!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16);
      });
    } else {
      setState(() {
        isLoading = false;
        if (isLoading) {
          IsShowDialog().showLoadingDialog(context);
        } else {
          Navigator.of(context).pop();
          Fluttertoast.showToast(
              msg: "Remove item successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
      });
    }
    return removeItemOrderResponse;
  }

  /// call api sum order
  Future<SumOrderResponse> sumOrderApi(SumOrderRequest sumOrderRequest) async {
    setState(() {
      isLoading = true;
      if (isLoading) {
        IsShowDialog().showLoadingDialog(context);
      } else {
        Navigator.of(context).pop();
      }
    });
    SumOrderResponse sumOrderResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("http://14.225.204.248:7070/api/order/sum"),
          RequestType.post,
          headers: null,
          body: const JsonEncoder().convert(sumOrderRequest.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to sum order $error");
      rethrow;
    }
    if (body == null) return SumOrderResponse.buildDefault();
    sumOrderResponse = SumOrderResponse.fromJson(body);
    if (sumOrderResponse.status == false) {
      setState(() {
        isLoading = false;
        if (isLoading) {
          IsShowDialog().showLoadingDialog(context);
        } else {
          Navigator.of(context).pop();
        }
        Fluttertoast.showToast(
            msg: "Sum order fail!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16);
      });
    } else {
      setState(() {
        isLoading = false;
        if (isLoading) {
          IsShowDialog().showLoadingDialog(context);
        } else {
          Navigator.of(context).pop();

          IsShowDialog().showDialogContent(context,
              "${sumOrderResponse.dataSumOrderResponse!.total}.000 VND");
        }
      });
    }

    return sumOrderResponse;
  }

  /// call api checkout  order
  Future<CheckoutOrderResponse> checkoutOrderApi(
      CheckoutOrderRequest checkoutOrderRequest) async {
    setState(() {
      isLoading = true;
      if (isLoading) {
        IsShowDialog().showLoadingDialog(context);
      } else {
        Navigator.of(context).pop();
      }
    });
    CheckoutOrderResponse checkoutOrderResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse(
              "http://14.225.204.248:7070/api/order/checkout"),
          RequestType.post,
          headers: null,
          body: const JsonEncoder()
              .convert(checkoutOrderRequest.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to checkout order $error");
      rethrow;
    }
    if (body == null) return CheckoutOrderResponse.buildDefault();
    checkoutOrderResponse = CheckoutOrderResponse.fromJson(body);
    if (checkoutOrderResponse.status == false) {
      setState(() {
        isLoading = false;
        if (isLoading) {
          IsShowDialog().showLoadingDialog(context);
        } else {
          Navigator.of(context).pop();
        }
        Fluttertoast.showToast(
            msg: "Checkout order fail!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16);
      });
    } else {
      setState(() {
        isLoading = false;
        if (isLoading) {
          IsShowDialog().showLoadingDialog(context);
        } else {
          Navigator.of(context).pop();
          Fluttertoast.showToast(
              msg: "Checkout order successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16);
          Global.orderId = "";
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
      });
    }

    return checkoutOrderResponse;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          child: const Icon(Icons.arrow_back),
        ),
        title: const Text("Cart Details"),
      ),
      body: bodyCart(),
    );
  }

  Widget bodyCart() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: listDataOrder!.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: cartItem(index),
                      ),
                      const Divider()
                    ],
                  );
                }),
          ),
          checkOutAndSumCart()
        ],
      ),
    );
  }

  Widget cartItem(index) {
    return Container(
      color: const Color(0xFFF5F5F5),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// title + price + delete
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 80,
                margin: const EdgeInsets.only(right: 10),
                child: Image.network(listDataOrder![index].image!,
                    fit: BoxFit.cover),
              ),
              Container(
                  constraints: const BoxConstraints(maxWidth: 140),
                  height: 30,
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(right: 10),
                  child: Text(
                    listDataOrder![index].title!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
              Container(
                  constraints: const BoxConstraints(maxWidth: 80),
                  height: 20,
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(right: 10),
                  child: Text(
                    "${listDataOrder![index].price!}.000 VND",
                    maxLines: 1,
                  )),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      if (Global.orderId.isNotEmpty) {
                        RemoveItemOrderRequest removeItemRequest =
                            RemoveItemOrderRequest(Global.orderId, index);
                        removeItemOrderApi(removeItemRequest);
                      }
                    });
                  },
                  child: const Icon(Icons.delete_outline))
            ],
          ),
        ],
      ),
    );
  }

  Widget checkOutAndSumCart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            if (Global.isAvailableToClick()) {
              if (Global.orderId.isNotEmpty) {
                SumOrderRequest sumOrderRequest =
                    SumOrderRequest(Global.orderId);
                sumOrderApi(sumOrderRequest);
              }
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green), color: Colors.white),
            child: Text(
              "Sum".toUpperCase(),
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (Global.isAvailableToClick()) {
              if (Global.orderId.isNotEmpty) {
                CheckoutOrderRequest checkoutOrderRequest =
                    CheckoutOrderRequest(Global.orderId);
                checkoutOrderApi(checkoutOrderRequest);
              }
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green), color: Colors.green),
            child: Text(
              "Check out".toUpperCase(),
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
