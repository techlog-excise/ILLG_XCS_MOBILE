
class ItemsListVersion {
  final int VERSION_ID;
  final int VERSION_TYPE;
  final String VERSION_NAME;
  final String FILE_PATH;
  final int IS_ACTIVE;

  ItemsListVersion({
    this.VERSION_ID,
    this.VERSION_TYPE,
    this.VERSION_NAME,
    this.FILE_PATH,
    this.IS_ACTIVE,
  });

  factory ItemsListVersion.fromJson(Map<String, dynamic> js) {
    return ItemsListVersion(
      //VERSION_ID: int.parse(js['VERSION_ID']),
      VERSION_ID: js['VERSION_ID '],
      VERSION_TYPE: js['VERSION_TYPE'],
      VERSION_NAME: js['VERSION_NAME'],
      FILE_PATH: js['FILE_PATH'],
      IS_ACTIVE: js['IS_ACTIVE'],
    );
  }
}