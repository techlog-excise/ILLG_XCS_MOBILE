
class ItemsTrackingProductGroup {
  final String PRODUCT_GROUP_NAME;
  ItemsTrackingProductGroup({
    this.PRODUCT_GROUP_NAME,
  });
  factory ItemsTrackingProductGroup.fromJson(Map<String, dynamic> json) {
    return ItemsTrackingProductGroup(
      PRODUCT_GROUP_NAME: json['PRODUCT_GROUP_NAME'],
    );
  }
}


