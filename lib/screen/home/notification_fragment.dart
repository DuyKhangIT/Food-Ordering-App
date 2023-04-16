import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationDetail extends StatefulWidget {
  static String routeName = "/push-page";
  const NotificationDetail({Key? key}) : super(key: key);

  @override
  State<NotificationDetail> createState() => _NotificationDetailState();
}

class _NotificationDetailState extends State<NotificationDetail> {
  @override
  Widget build(BuildContext context) {
    return Text("Push message");
  }
}
