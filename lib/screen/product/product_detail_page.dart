import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:th_flutter/model/get_products/foods_info.dart';

import '../../util/global.dart';
import '../cart/cart_page.dart';

class ProductDetailPage extends StatefulWidget {
  final FoodsInfo? dataFood;
  static String routeName = "/product_screen";
  ProductDetailPage({Key? key, required this.dataFood}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
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
          Fluttertoast.showToast(
              msg: "Add to cart successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16);
        }

        Navigator.pushNamedAndRemoveUntil(context, CartPage.routeName, (Route<dynamic> route) => false);
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
