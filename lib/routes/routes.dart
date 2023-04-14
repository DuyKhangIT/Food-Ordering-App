
import 'package:flutter/material.dart';
import 'package:th_flutter/screen/cart/cart_page.dart';
import 'package:th_flutter/screen/home/home_page.dart';
import 'package:th_flutter/screen/product/product_detail_page.dart';
import 'package:th_flutter/screen/sign_in/sign_in_page.dart';
import 'package:th_flutter/screen/sign_up/sign_up_page.dart';
import 'package:th_flutter/screen/splash_page.dart';

final Map<String,WidgetBuilder> routes = {
  SplashPage.routeName: (context) => SplashPage(),
  SignInPage.routeName: (context) => SignInPage(),
  SignUpPage.routeName: (context) => SignUpPage(),
  HomePage.routeName: (context) => HomePage(),
  ProductDetailPage.routeName: (context) => ProductDetailPage(dataFood: null,),
  CartPage.routeName: (context) => CartPage(dataOrder: null,),
};