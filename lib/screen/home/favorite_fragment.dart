import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:th_flutter/assets/assets.dart';
import 'package:th_flutter/model/get_list_favorite/get_list_favorite_request/get_list_favorite_request.dart';
import 'package:th_flutter/model/get_list_favorite/get_list_favorite_response/favorite_foods_response.dart';
import 'package:th_flutter/model/get_list_favorite/get_list_favorite_response/get_list_favorite_response.dart';

import '../../handle_api/handle_api.dart';
import '../../util/global.dart';
import '../../util/share_preferences.dart';
import '../../util/show_loading_dialog.dart';

class FavoriteDetail extends StatefulWidget {
  const FavoriteDetail({Key? key}) : super(key: key);

  @override
  State<FavoriteDetail> createState() => _FavoriteDetailState();
}

class _FavoriteDetailState extends State<FavoriteDetail> {
  String username = "";
  List<FavoriteFoodsResponse>? listFav;
  bool isLoading = false;


  Future<void> getUserName() async {
    username = await ConfigSharedPreferences()
        .getStringValue(SharedData.USERNAME.toString(), defaultValue: "");
    setState(() {
      if (username.isNotEmpty || username != "") {
        GetListFavoriteRequest getListFavoriteRequest =
            GetListFavoriteRequest(username);
        getListFavorites(getListFavoriteRequest);
      }
    });
  }

  @override
  void initState() {
    getUserName();
    super.initState();
  }

  /// call api list favorite
  Future<GetListFavoriteResponse> getListFavorites(
      GetListFavoriteRequest getListFavoriteRequest) async {
    setState(() {
      isLoading = true;
      if (isLoading) {
        IsShowLoading().showLoadingDialog(context);
      } else {
        Navigator.of(context).pop();
      }
    });
    GetListFavoriteResponse getListFavoriteResponse;
    Map<String, dynamic>? body;
    try {
      body = await HttpHelper.invokeHttp(
          Uri.parse("https://apibeflutterdlaw.up.railway.app/api/fav/"),
          RequestType.post,
          headers: null,
          body: const JsonEncoder()
              .convert(getListFavoriteRequest.toBodyRequest()));
    } catch (error) {
      debugPrint("Fail to list fav $error");
      rethrow;
    }
    if (body == null) return GetListFavoriteResponse.buildDefault();
    //get data from api here
    getListFavoriteResponse = GetListFavoriteResponse.fromJson(body);

    List<FavoriteFoodsResponse> favoriteFoodsList = [];
    if (getListFavoriteResponse
            .dataListFavoriteResponse!.favoriteObjectResponse !=
        null) {
      for (int i = 0;
          i <
              getListFavoriteResponse.dataListFavoriteResponse!
                  .favoriteObjectResponse!.favoriteFood!.length;
          i++) {
        FavoriteFoodsResponse favoriteFoodsListResponse =
            getListFavoriteResponse.dataListFavoriteResponse!
                .favoriteObjectResponse!.favoriteFood![i];
        favoriteFoodsList.add(FavoriteFoodsResponse(
          favoriteFoodsListResponse.id ??= "",
          favoriteFoodsListResponse.title ??= "",
          favoriteFoodsListResponse.description ??= "",
          favoriteFoodsListResponse.image ??= "",
          favoriteFoodsListResponse.price ??= 0,
        ));
      }
    }
    if (getListFavoriteResponse.status == true) {
      setState(() {
        isLoading = false;
        if (isLoading) {
          IsShowLoading().showLoadingDialog(context);
        } else {
          Navigator.of(context).pop();
          listFav = getListFavoriteResponse
              .dataListFavoriteResponse!.favoriteObjectResponse!.favoriteFood;
        }
      });
    } else {
      setState(() {
        isLoading = false;
        if (isLoading) {
          IsShowLoading().showLoadingDialog(context);
        } else {
          Navigator.of(context).pop();
          Fluttertoast.showToast(
              msg: "get list favorite fail!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16);
        }
      });
    }

    return getListFavoriteResponse;
  }

  @override
  Widget build(BuildContext context) {
    return listFav != null && listFav!.isNotEmpty
        ? Expanded(
            child: ListView.builder(
                itemCount: listFav!.length,
                itemBuilder: (context, index) {
                  return productItemList(context, index);
                }))
        : Expanded(child: Center(child: Text("You don't have any favorites")));
  }

  Widget productItemList(BuildContext context, index) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          SizedBox(
              width: 100,
              height: 100,
              child: Image.network(
                listFav![index].image!,
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
                    child: Text(listFav![index].title!,
                        overflow: TextOverflow.ellipsis, maxLines: 1)),

                ///api
                Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    constraints: const BoxConstraints(maxHeight: 80),
                    child: Text(
                      listFav![index].description!,

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
