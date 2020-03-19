
class ItemsListProveID {
  final int PROVE_ID;
  final int LAWSUIT_ID;

  ItemsListProveID({
    this.PROVE_ID,
    this.LAWSUIT_ID,
  });

  factory ItemsListProveID.fromJson(Map<String, dynamic> js) {
    return ItemsListProveID(
      PROVE_ID: js['PROVE_ID'],
      LAWSUIT_ID: js['LAWSUIT_ID'],
    );
  }
}