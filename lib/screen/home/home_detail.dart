import 'package:flutter/material.dart';
import 'package:th_flutter/screen/home/home_fragement_product.dart';
import 'package:th_flutter/screen/home/home_fragment_categories.dart';

class HomeDetail extends StatelessWidget {
  const HomeDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [CategoriesStore(), ProductPopular()],
        ),
    );
  }
}
