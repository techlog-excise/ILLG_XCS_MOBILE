
class ItemsArrestResponseStaffMessage {
  final int RESPONSE_DATA;
  final bool SUCCESS;

  ItemsArrestResponseStaffMessage({
    this.RESPONSE_DATA,
    this.SUCCESS,
  });

  factory ItemsArrestResponseStaffMessage.fromJson(Map<String, dynamic> json) {
    return ItemsArrestResponseStaffMessage(
      RESPONSE_DATA: json['RESPONSE_DATA'],
      SUCCESS: json['SUCCESS'],
    );
  }
}