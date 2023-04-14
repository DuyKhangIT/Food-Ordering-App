import 'data_info.dart';

class ProductInfo {
  bool mStatus = false;
  DataInfo? mDataInfo;

  ProductInfo.buildDefault();

  ProductInfo(
    this.mStatus,
    this.mDataInfo,
  );
}
