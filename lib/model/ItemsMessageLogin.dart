class ItemsMessageLogin {
  String success;
  String code;
  String description;
  ItemsMessageLogin({
    this.success,
    this.code,
    this.description,
  });
  factory ItemsMessageLogin.fromJson(Map<String, dynamic> json) {
    return ItemsMessageLogin(
      success: json['success'],
      code: json['code'],
      description: json['description'],
    );
  }
}