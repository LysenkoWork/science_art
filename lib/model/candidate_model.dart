class Candidate {
  String? id;
  String? name;
  String? surname;
  String? patronymic;
  String? workname;
  String? ageCategory;
  String? job;
  String? email;
  String? section;
  String? phoneNumber;
  String? leadership;
  String? insertDate;
  String? description;
  String? updateDate;
  String? filename;
  String? filesize;
  String? filedata;

  Candidate(
      {this.id,
      this.name,
      this.surname,
      this.patronymic,
      this.workname,
      this.ageCategory,
      this.job,
      this.email,
      this.section,
      this.phoneNumber,
      this.leadership,
      this.insertDate,
      this.description,
      this.updateDate,
      this.filename,
      this.filesize,
      this.filedata,
      });

  Candidate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    surname = json['surname'];
    patronymic = json['patronymic'];
    workname = json['workname'];
    ageCategory = json['age_category'];
    job = json['job'];
    email = json['email'];
    section = json['section'];
    phoneNumber = json['phone_number'];
    leadership = json['leadership'];
    insertDate = json['insert_date'];
    description = json['description'];
    updateDate = json['update_date'];
    filename = json['filename'];
    filesize = json['filesize'];
    filedata = json['filedata'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['surname'] = surname;
    data['patronymic'] = patronymic;
    data['workname'] = workname;
    data['age_category'] = ageCategory;
    data['job'] = job;
    data['email'] = email;
    data['section'] = section;
    data['phone_number'] = phoneNumber;
    data['leadership'] = leadership;
    data['insert_date'] = insertDate;
    data['description'] = description;
    data['update_date'] = updateDate;
    data['filename'] = filename;
    data['filesize'] = filesize;
    data['filedata'] = filedata;
    return data;
  }
}
