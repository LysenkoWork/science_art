class ReitingModel {
  String? cid;
  String? name;
  String? surname;
  String? patronymic;
  String? workname;
  String? ageCategory;
  String? section;
  String? insertDate;
  String? filename;
  String? ballov;

  ReitingModel(
      {this.cid,
      this.name,
      this.surname,
      this.patronymic,
      this.workname,
      this.ageCategory,
      this.section,
      this.insertDate,
      this.filename,
      this.ballov});

  ReitingModel.fromJson(Map<String, dynamic> json) {
    cid = json['cid'];
    name = json['name'];
    surname = json['surname'];
    patronymic = json['patronymic'];
    workname = json['workname'];
    ageCategory = json['age_category'];
    section = json['section'];
    insertDate = json['insert_date'];
    filename = json['filename'];
    ballov = json['ballov'];
  }

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   data['cid'] = this.cid;
//   data['name'] = this.name;
//   data['surname'] = this.surname;
//   data['patronymic'] = this.patronymic;
//   data['workname'] = this.workname;
//   data['age_category'] = this.ageCategory;
//   data['section'] = this.section;
//   data['insert_date'] = this.insertDate;
//   data['filename'] = this.filename;
//   data['ballov'] = this.ballov;
//   return data;
// }
}
