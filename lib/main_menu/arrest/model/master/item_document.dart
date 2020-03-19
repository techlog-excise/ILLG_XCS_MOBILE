import 'dart:io';

class ItemsListDocument {
  int DOCUMENT_ID;
  String REFERENCE_CODE;
  String FILE_PATH;
  String DATA_SOURCE;
  int DOCUMENT_TYPE;
  String DOCUMENT_NAME;
  String IS_ACTIVE;
  String DOCUMENT_OLD_NAME;
  String CONTENT;
  int FILE_TYPE;
  String FOLDER;

  File FILE_CONTENT;

  ItemsListDocument({
    this.DOCUMENT_ID,
    this.REFERENCE_CODE,
    this.FILE_PATH,
    this.DATA_SOURCE,
    this.DOCUMENT_TYPE,
    this.DOCUMENT_NAME,
    this.IS_ACTIVE,
    this.DOCUMENT_OLD_NAME,
    this.CONTENT,
    this.FILE_TYPE,
    this.FOLDER,

    this.FILE_CONTENT,
  });

  factory ItemsListDocument.fromJson(Map<String, dynamic> json) {
    return ItemsListDocument(
      DOCUMENT_ID: json['DOCUMENT_ID'],
      REFERENCE_CODE: json['REFERENCE_CODE'],
      FILE_PATH: json['FILE_PATH'],
      DATA_SOURCE: json['DATA_SOURCE'],
      DOCUMENT_TYPE: json['DOCUMENT_TYPE'],
      DOCUMENT_NAME: json['DOCUMENT_NAME'],
      IS_ACTIVE: json['IS_ACTIVE'],
      DOCUMENT_OLD_NAME: json['DOCUMENT_OLD_NAME'],
      CONTENT: json['CONTENT'],
      FILE_TYPE: json['FILE_TYPE'],
      FOLDER: json['FOLDER'],

      FILE_CONTENT: null,
    );
  }
}