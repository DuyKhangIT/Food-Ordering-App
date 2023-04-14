import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:th_flutter/screen/home/appbar/search_header.dart';

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
        title: homePage? const Text("Home") :flag ? const SearchHeader() : const MenuHeader(),
        actions: homePage ? [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20,top: 5),
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
        ] : null,
        centerTitle: homePage ? true : false,
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectIndex,
        onTap: (index){
          setState(() {
            selectIndex = index;
            if(selectIndex == 0){
              homePage = true;
            }else{
              homePage = false;
            }
            if(selectIndex !=3){
              flag = true;
            }else{
              flag = false;
            }
          });
        },
        items: const[
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favorite'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications),label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle),label: 'Account'),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10,),
            screen[selectIndex]
          ],
        ),
      ),
    );
  }
}
