class ItemsOAGLoginResponse {
  String userThaiId;

  ItemsOAGLoginResponse({
    this.userThaiId,
  });

  factory ItemsOAGLoginResponse.fromJson(Map<String, dynamic> json) {
    return ItemsOAGLoginResponse(
      userThaiId: json['Body']['ResponseObj']['userThaiId'],
    );
  }
}
