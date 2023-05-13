class BallovModel {
  String? ballov;

  BallovModel({
    this.ballov,
  });

  BallovModel.fromJson(Map<String, dynamic> json) {
    ballov = json['ballov'];
  }
}
