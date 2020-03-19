class ItemsCompareCV {
  final String ID;
  final String DATAFILE;

  ItemsCompareCV({
    this.ID,
    this.DATAFILE,
  });

  factory ItemsCompareCV.fromJson(Map<String, dynamic> js) {
    return ItemsCompareCV(
      ID: js['id'],
      DATAFILE: js['dataFile'],
    );
  }
}
