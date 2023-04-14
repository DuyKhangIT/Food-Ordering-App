import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:th_flutter/model/get_products/foods_info.dart';
import 'package:th_flutter/model/post_order/order_request/post_order_request.dart';
import 'package:th_flutter/model/post_order/order_response/post_order_response.dart';
import 'package:th_flutter/screen/home/home_page.dart';

import '../../handle_api/handle_api.dart';
import '../../util/global.dart';
import '../../util/share_preferences.dart';
import '../../util/show_loading_dialog.dart';
import '../cart/cart_page.dart';

class ProductDetailPage extends StatefulWidget {
  final FoodsInfo? dataFood;
  static String routeName = "/product_screen";
  const ProductDetailPage({Key? key, required this.dataFood}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool isLoading = false;
  String username = "";

  @override
  void initState() {
    getUserName();
    super.initState();
  }

  Future<void> getUserName() async {
    username = await ConfigSharedPreferences()
        .getStringValue(SharedData.USERNAME.toString(), defaultValue: "");
    setState(() {
      username;
    });
  }

  /// call api add to cart
  Future<PostOrderResponse> addToCartApi(
      PostOrderRequest postOrderRequest) async {
    setState(() {
      isLoading = true;
      if (isLoading) {
        IsShowLoading().showLoadingDialog(context);
      } else {
        Navigator.of(context).pop();
      }
    });
    PostOrderResponse postOrderResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("https://apibeflutterdlaw.up.railway.app/api/order"),
          RequestType.post,
          headers: null,
          body: const JsonEncoder().convert(postOrderRequest.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to add to cart $error");
      rethrow;
    }
    if (body == null) return PostOrderResponse.buildDefault();
    postOrderResponse = PostOrderResponse.fromJson(body);
    if (postOrderResponse.status == false) {
      setState(() {
        isLoading = false;
        if (isLoading) {
          IsShowLoading().showLoadingDialog(context);
        } else {
          Navigator.of(context).pop();
        }
      });
      Fluttertoast.showToast(
          msg: "Add to cart fail",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16);
    } else {
      setState(() {
        isLoading = false;
        if (isLoading) {
          IsShowLoading().showLoadingDialog(context);
        } else {
          Navigator.of(context).pop();
          Fluttertoast.showToast(
              msg: "Add to cart Successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16);
        }
      });
    }

    return postOrderResponse;
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
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
          child: const Icon(Icons.arrow_back),
        ),
        title: const Text("Details"),
      ),
      body: bodyProduct(context),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: 130,
        margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// quantity
            addToFavourite(context),
            addToCart(context),
          ],
        ),
      ),
    );
  }

  Widget bodyProduct(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
            margin: const EdgeInsets.only(bottom: 20),
            child: Image.network(widget.dataFood!.mImage, fit: BoxFit.cover),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              constraints: const BoxConstraints(minHeight: 100),
              child: Text(widget.dataFood!.mDescription)),
        ],
      ),
    );
  }

  Widget addToCart(BuildContext context) {
    return InkWell(
      onTap: () {
        if (Global.isAvailableToClick()) {
          if (username.isNotEmpty && widget.dataFood!.mId.isNotEmpty) {
            PostOrderRequest postOrderRequest = PostOrderRequest(
                username, Global.orderId, widget.dataFood!.mId);
            addToCartApi(postOrderRequest);
          } else {
            Fluttertoast.showToast(
                msg: "Something wrong",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16);
          }
        }
      },
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(10)),
          child: const Text(
            "Add to cart",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget addToFavourite(BuildContext context) {
    return InkWell(
      onTap: () {
        if (Global.isAvailableToClick()) {
          Fluttertoast.showToast(
              msg: "Add to favorites successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.teal,
              textColor: Colors.white,
              fontSize: 16);
        }
      },
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(10)),
          child: const Text(
            "Add to favorites",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
