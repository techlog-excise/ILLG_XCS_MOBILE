class ItemsCompareImgSignature {
  final String USERNAME;
  final String OFFCODE;
  final String FILETYPE;
  final String FILEBODY;

  ItemsCompareImgSignature({
    this.USERNAME,
    this.OFFCODE,
    this.FILETYPE,
    this.FILEBODY,
  });

  factory ItemsCompareImgSignature.fromJson(Map<String, dynamic> js) {
    return ItemsCompareImgSignature(
      USERNAME: js['UserName'],
      OFFCODE: js['OffCode'],
      FILETYPE: js['FileType'],
      FILEBODY: js['FileBody'],
    );
  }
}
