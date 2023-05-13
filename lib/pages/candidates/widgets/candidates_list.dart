import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../../model/candidate_model.dart';
import '../../../model/models.dart';
import 'candidate_card.dart';

class CandidatesList extends StatelessWidget {
  CandidatesList({
    Key? key,
    required this.candidates,
    this.user,
  }) : super(key: key);
  final List<Candidate> candidates;
  User? user;

  Future<Candidate> getFile(Candidate candidate) async {
    String url = 'http://science-art.pro/test02.php';
    final Response response = await post(Uri.parse(url), body: {
      'id': candidate.id,
    });
//    final Candidate candidate = Candidate.fromJson(json.decode(response.body));
    return Candidate.fromJson(json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 150,
        right: 150,
      ),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: candidates.length,
        itemBuilder: (context, index) {
          {
            return CandidateCard(
              candidate: candidates[index],
              user: user,
            );
          }
        },
      ),
    );
  }
}
