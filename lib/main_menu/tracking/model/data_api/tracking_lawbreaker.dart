
class ItemsTrackingLawbreker {
  final String ARREST_LAWBREAKER_NAME;
  ItemsTrackingLawbreker({
    this.ARREST_LAWBREAKER_NAME,
  });
  factory ItemsTrackingLawbreker.fromJson(Map<String, dynamic> json) {
    return ItemsTrackingLawbreker(
      ARREST_LAWBREAKER_NAME: json['ARREST_LAWBREAKER_NAME'],
    );
  }
}


