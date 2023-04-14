import 'package:th_flutter/model/get_categories/data_categories_info.dart';

class StoreInfo {
  bool mStatus = false;
  DataCategoriesInfo? mDataCategoriesInfo;

  StoreInfo.buildDefault();

  StoreInfo(
    this.mStatus,
    this.mDataCategoriesInfo,
  );
}
