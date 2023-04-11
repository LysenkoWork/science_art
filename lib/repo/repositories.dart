import 'dart:convert';
import '/model/candidate_model.dart';
import '/model/models.dart';
import 'package:http/http.dart';

class UserRepository {
  String url = 'http://science-art.pro/test01.php';

  Future<List<User>> getList() async {
    Response response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result.map((e) => User.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}

class CandidateRepository {

  Future<List<Candidate>> getList() async {
    String url = 'http://science-art.pro/test07.php';
    Response response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result.map((e) => Candidate.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> add(Candidate candidate) async {
    String url = 'http://science-art.pro/test05.php';

      Response  response = await post(Uri.parse(url),
        body: {
          'name': candidate.name,
          'surname': candidate.surname,
          'patronymic': candidate.patronymic,
          'workname': candidate.workname,
          'age_category': candidate.ageCategory,
          'job': candidate.job,
          'email': candidate.email,
          'section': candidate.section,
          'phone_number': candidate.phoneNumber,
          'leadership': candidate.leadership,
          'insert_date': candidate.insertDate,
          'description': candidate.description,
          'update_date': candidate.updateDate,
          'filename': candidate.filename,
          'filesize': candidate.filesize,
          'filedata': candidate.filedata,
        }
      );
      if (response.statusCode != 200) {
          throw Exception(response.reasonPhrase);
        }
    }
  }





