import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:th_flutter/assets/assets.dart';

class FavoriteDetail extends StatelessWidget {
  //List<Product> products;
  const FavoriteDetail({Key? key}) : super(key: key);
  //FavoriteDetail({Key? key,required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            itemCount: 6,
            itemBuilder: (context, index) {
              return productItemList(context);
            }));
  }

  Widget productItemList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          SizedBox(
              width: 100,
              height: 100,
              child: Image.asset(
                ImageAssets.imgDash,
                fit: BoxFit.cover,
              )),
          const SizedBox(
            width: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.5,
            constraints: const BoxConstraints(maxHeight: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: 20,
                    child: const Text("product.tittle",
                        overflow: TextOverflow.ellipsis, maxLines: 1)),

                ///api
                Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    constraints: const BoxConstraints(maxHeight: 80),
                    child: const Text(
                      "product.descriptionproduct",

                      ///api
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
