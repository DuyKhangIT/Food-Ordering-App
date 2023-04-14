import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:th_flutter/screen/home/appbar/search_header.dart';

import '../../handle_api/handle_api.dart';
import '../../model/get_order/get_order_response/get_order_response.dart';
import '../../model/get_order/get_order_response/order_detail_response_get.dart';
import '../../model/get_order/get_order_response/response_order_list.dart';
import '../../util/global.dart';
import '../../util/share_preferences.dart';
import '../cart/cart_page.dart';
import 'account_fragment.dart';
import 'appbar/menu_header.dart';
import 'favorite_fragment.dart';
import 'home_detail.dart';
import 'notification_fragment.dart';

class HomePage extends StatefulWidget {
  static String routeName = "/home_screen";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectIndex = 0;
  var flag = true;
  bool homePage = true;
  List<OrderDetailResponseGet>? listDataOrder;
  String userId = "";

  Future<void> getUserName() async {
    userId = await ConfigSharedPreferences()
        .getStringValue(SharedData.ID.toString(), defaultValue: "");
    setState(() {
      if (userId.isNotEmpty || userId != "") {
        getListCartOrders();
      }
    });
  }

  @override
  void initState() {
    getUserName();
    super.initState();
  }

  /// call api list cart orders
  Future<GetOrderResponse> getListCartOrders() async {
    GetOrderResponse getOrderResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse(
              "https://apibeflutterdlaw.up.railway.app/api/order/$userId"),
          RequestType.get,
          headers: null,
          body: null);
    } catch (error) {
      debugPrint("Fail to list cart orders $error");
      rethrow;
    }
    if (body == null) return GetOrderResponse.buildDefault();
    //get data from api here
    getOrderResponse = GetOrderResponse.fromJson(body);

    List<OrderDetailResponseGet> orderDetailResponse = [];
    if (getOrderResponse.dataGetOrderResponse!.responseOrderList != null) {
      for (int i = 0;
          i <
              getOrderResponse.dataGetOrderResponse!.responseOrderList!
                  .orderDetailResponseGet!.length;
          i++) {
        OrderDetailResponseGet orderDetailResponseGet = getOrderResponse
            .dataGetOrderResponse!
            .responseOrderList!
            .orderDetailResponseGet![i];
        orderDetailResponse.add(OrderDetailResponseGet(
          orderDetailResponseGet.id ??= "",
          orderDetailResponseGet.title ??= "",
          orderDetailResponseGet.description ??= "",
          orderDetailResponseGet.image ??= "",
          orderDetailResponseGet.price ??= 0,
        ));
      }
    }
    setState(() {
      if(getOrderResponse
          .dataGetOrderResponse!.responseOrderList!.orderDetailResponseGet!=null){
        listDataOrder = getOrderResponse
            .dataGetOrderResponse!.responseOrderList!.orderDetailResponseGet!;
      }
      Global.orderId =
          getOrderResponse.dataGetOrderResponse!.responseOrderList!.orderId;
    });

    return getOrderResponse;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screen = [
      const HomeDetail(),
      const FavoriteDetail(),
      const NotificationDetail(),
      const AccountDetail()
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
        title: homePage
            ? const Text("Home")
            : flag
                ? const SearchHeader()
                : const MenuHeader(),
        actions: homePage
            ? [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CartPage(
                                dataOrder: listDataOrder,
                              )),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20, top: 5),
                    child: Stack(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          padding: const EdgeInsets.all(10),
                          child: const Icon(Icons.shopping_cart_outlined),
                        ),
                        Positioned(
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(1.5),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: const Text(
                              "9",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ]
            : null,
        centerTitle: homePage ? true : false,
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectIndex,
        onTap: (index) {
          setState(() {
            selectIndex = index;
            if (selectIndex == 0) {
              homePage = true;
            } else {
              homePage = false;
            }
            if (selectIndex != 3) {
              flag = true;
            } else {
              flag = false;
            }
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorite'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Account'),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            screen[selectIndex]
          ],
        ),
      ),
    );
  }
}
