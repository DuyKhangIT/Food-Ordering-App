import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:th_flutter/assets/assets.dart';

import '../../util/global.dart';
import '../home/home_page.dart';

class CartPage extends StatefulWidget {
  static String routeName = "/cart_screen";
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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
                itemCount: 3,
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
                child: Image.asset(ImageAssets.imgDash, fit: BoxFit.cover),
              ),
              Container(
                  constraints: const BoxConstraints(maxWidth: 150),
                  height: 30,
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(right: 10),
                  child: const Text(
                    "Trà sữa truyền thống",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
              Container(
                  constraints: const BoxConstraints(maxWidth: 65),
                  height: 20,
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(right: 10),
                  child: const Text(
                    "100.000",
                    maxLines: 1,
                  )),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      //itemList.removeAt(index);
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
          onTap: () {},
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
              Fluttertoast.showToast(
                  msg: "Order successfully",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.teal,
                  textColor: Colors.white,
                  fontSize: 16);
              //Navigator.pushNamedAndRemoveUntil(context, HomePage.routeName, (Route<dynamic> route) => false);
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
