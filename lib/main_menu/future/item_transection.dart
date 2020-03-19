
class ItemsListTransection {
  final int RUNNING_ID;
  final int RUNNING_OFFICE_ID;
  final int RUNNING_NO;
  final String RUNNING_TABLE;
  final String RUNNING_PREFIX;
  final String RUNNING_OFFICE_CODE;
  final String RUNNING_YEAR;
  final String RUNNING_MONTH;

  ItemsListTransection({
    this.RUNNING_ID,
    this.RUNNING_OFFICE_ID,
    this.RUNNING_NO,
    this.RUNNING_TABLE,
    this.RUNNING_PREFIX,
    this.RUNNING_OFFICE_CODE,
    this.RUNNING_YEAR,
    this.RUNNING_MONTH,
  });

  factory ItemsListTransection.fromJson(Map<String, dynamic> js) {
    return ItemsListTransection(
      RUNNING_ID: js['RUNNING_ID'],
      RUNNING_OFFICE_ID: js['RUNNING_OFFICE_ID'],
      RUNNING_NO: js['RUNNING_NO'],
      RUNNING_TABLE: js['RUNNING_TABLE'],
      RUNNING_PREFIX: js['RUNNING_PREFIX'],
      RUNNING_OFFICE_CODE: js['RUNNING_OFFICE_CODE'],
      RUNNING_YEAR: js['RUNNING_YEAR'],
      RUNNING_MONTH: js['RUNNING_MONTH'],
    );
  }
}