import 'dart:convert';
import 'package:http/http.dart';
import 'package:science_art/model/ballov_model.dart';
import '../../../model/candidate_model.dart';

class CandidateApiProvider {
  Future<List<Candidate>> getList() async {
    String url = 'http://science-art.pro/test07.php';
    final Response response = await get(Uri.parse(url));
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Candidate> candidates = items.map<Candidate>((json) {
      return Candidate.fromJson(json);
    }).toList();
    return candidates;
  }

  Future<Candidate> getFile(Candidate candidate) async {
    String url = 'http://science-art.pro/test02.php';
    final Response response = await post(Uri.parse(url), body: {
      'id': candidate.id,
    });
//    final Candidate candidate = Candidate.fromJson(json.decode(response.body));
    return Candidate.fromJson(json.decode(response.body));
  }

  Future<Candidate?> deleteCandidate(Candidate candidate) async {
    String url = 'http://science-art.pro/delcan.php';
    final Response response = await post(Uri.parse(url), body: {
      'id': candidate.id,
    });
    return null;
  }

  Future<Response?> addRating(String cid, String uid, String ball) async {
    String url = 'http://science-art.pro/addreiting.php';
    final Response response = await post(Uri.parse(url), body: {
      'cid': cid,
      'uid': uid,
      'ballov': ball,
    });

    return response;
  }

  Future<BallovModel> getRating(String cid, String uid) async {
    String url = 'http://science-art.pro/reitinguser.php';
    final Response response = await post(
      Uri.parse(url),
      body: {
        'cid': cid,
        'uid': uid,
      },
    );
    // BallovModel rating = response.body;

    return BallovModel.fromJson(json.decode(response.body));
  }
}
