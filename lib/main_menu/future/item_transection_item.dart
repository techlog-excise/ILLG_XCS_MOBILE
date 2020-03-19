
class ItemsListTransectionItem {
  final int RUNNING_ID;
  final int PRODUCT_GROUP_ID;
  final int WAREHOUSE_ID;
  final int RUNNING_NO;
  final String RUNNING_YEAR;
  final String RUNNING_MONTH;
  final String RUNNING_PREFIX;

  ItemsListTransectionItem({
    this.RUNNING_ID,
    this.PRODUCT_GROUP_ID,
    this.WAREHOUSE_ID,
    this.RUNNING_NO,
    this.RUNNING_YEAR,
    this.RUNNING_MONTH,
    this.RUNNING_PREFIX,
  });

  factory ItemsListTransectionItem.fromJson(Map<String, dynamic> js) {
    return ItemsListTransectionItem(
      RUNNING_ID: js['RUNNING_ID'],
      PRODUCT_GROUP_ID: js['PRODUCT_GROUP_ID'],
      WAREHOUSE_ID: js['WAREHOUSE_ID'],
      RUNNING_NO: js['RUNNING_NO'],
      RUNNING_YEAR: js['RUNNING_YEAR'],
      RUNNING_MONTH: js['RUNNING_MONTH'],
      RUNNING_PREFIX: js['RUNNING_PREFIX'],
    );
  }
}