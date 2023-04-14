import 'package:flutter/material.dart';
import 'package:th_flutter/assets/assets.dart';
import 'package:th_flutter/model/get_categories/categories_info.dart';
import 'package:th_flutter/model/get_categories/categories_response.dart';
import 'package:th_flutter/model/get_categories/data_categories_info.dart';
import 'package:th_flutter/model/get_categories/store_info.dart';
import 'package:th_flutter/model/get_categories/store_response.dart';
import 'package:th_flutter/screen/categories/list_all_categories.dart';

import '../../handle_api/handle_api.dart';

class CategoriesStore extends StatefulWidget {
  const CategoriesStore({Key? key}) : super(key: key);

  @override
  State<CategoriesStore> createState() => _CategoriesStoreState();
}

class _CategoriesStoreState extends State<CategoriesStore> {
  List<CategoriesInfo>? dataCategories;
  StoreInfo? dataStore;
  @override
  void initState() {
    getStore();
    super.initState();
  }

  /// call api
  Future<StoreInfo> getStore() async {
    StoreResponse storeResponse;
    StoreInfo storeInfo;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("https://apibeflutterdlaw.up.railway.app/api/category"),
          RequestType.get,
          headers: null,
          body: null);
    } catch (error) {
      debugPrint("Fail to foods info $error");
      rethrow;
    }
    if (body == null) return StoreInfo.buildDefault();
    //get data from api here
    storeResponse = StoreResponse.fromJson(body);

    List<CategoriesInfo> categoriesInfo = [];
    if (storeResponse.dataCategoriesResponse != null) {
      for (int i = 0;
          i < storeResponse.dataCategoriesResponse!.listCategories!.length;
          i++) {
        CategoriesResponse categoriesResponse =
            storeResponse.dataCategoriesResponse!.listCategories![i];
        categoriesInfo.add(CategoriesInfo(
          categoriesResponse.id ??= "",
          categoriesResponse.title ??= "",
          categoriesResponse.image ??= "",
        ));
      }
    }
    storeInfo = StoreInfo(
      storeResponse.status!,
      (storeResponse.dataCategoriesResponse != null)
          ? DataCategoriesInfo(
              categoriesInfo,
            )
          : null,
    );
    setState(() {
      dataCategories = storeInfo.mDataCategoriesInfo!.mCategoriesInfo;
      dataStore = storeInfo;
    });

    return storeInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4.3,
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                  child: Text(
                "Categories",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              )),
              GestureDetector(
                onTap: () {
                  if (dataCategories != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ListAllCategories(storeInfo: dataStore!)));
                  }
                },
                child: const Text(
                  "See more",
                  style: TextStyle(fontSize: 16, color: Colors.lightGreen),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          dataCategories != null
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dataCategories!.length,

                      /// data.length
                      itemBuilder: (context, index) {
                        return Container(
                          width: 150, height: 150,
                          padding: const EdgeInsets.all(5),

                          /// call api img
                          child: dataCategories![index].mImage.isNotEmpty
                              ? Image.network(dataCategories![index].mImage,
                                  fit: BoxFit.cover)
                              : const SizedBox(),
                        );
                      }),
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: 120,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(
                    color: Colors.green,
                  )),
        ],
      ),
    );
  }
}
