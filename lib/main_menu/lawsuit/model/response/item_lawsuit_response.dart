

class ItemsArrestResponseMessage {
  final String IsSuccess;
  final String Msg;

  ItemsArrestResponseMessage({
    this.IsSuccess,
    this.Msg,
  });

  factory ItemsArrestResponseMessage.fromJson(Map<String, dynamic> json) {
    return ItemsArrestResponseMessage(
      IsSuccess: json['IsSuccess'],
      Msg: json['Msg'],
    );
  }
}
