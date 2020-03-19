
class ItemsCountOffense {
  final int COUNT;
  final String SUPOFFCODE;
  final String OFFCODE;
  final String OFFNAME;
  final String SHORT_NAME;
  final String INDC_OFF;
  final int ZONE_ID;
  final String ZONE_OFFCODE;
  final String ZONE_OFFNAME;
  final String ZONE_SHORT_NAME;
  final String ZONE_INDC_OFF;

  ItemsCountOffense({
    this.COUNT,
    this.SUPOFFCODE,
    this.OFFCODE,
    this.OFFNAME,
    this.SHORT_NAME,
    this.INDC_OFF,
    this.ZONE_ID,
    this.ZONE_OFFCODE,
    this.ZONE_OFFNAME,
    this.ZONE_SHORT_NAME,
    this.ZONE_INDC_OFF
  });

  factory ItemsCountOffense.fromJson(Map<String, dynamic> json) {
    return ItemsCountOffense(
        COUNT: json['COUNT'],
        SUPOFFCODE: json['SUPOFFCODE'],
        OFFCODE: json['OFFCODE'],
        OFFNAME: json['OFFNAME'],
        SHORT_NAME: json['SHORT_NAME'],
        INDC_OFF: json['INDC_OFF'],
        ZONE_ID: json['ZONE_ID'],
        ZONE_OFFCODE: json['ZONE_OFFCODE'],
        ZONE_OFFNAME: json['ZONE_OFFNAME'],
        ZONE_SHORT_NAME: json['ZONE_SHORT_NAME'],
        ZONE_INDC_OFF: json['ZONE_INDC_OFF']
    );
  }
}