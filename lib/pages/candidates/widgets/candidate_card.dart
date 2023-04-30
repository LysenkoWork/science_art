import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../../model/candidate_model.dart';
import '../pages/candidate_detail_page.dart';
import 'package:path/path.dart' as p;
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';

class CandidateCard extends StatelessWidget {
  const CandidateCard({Key? key, required this.candidate}) : super(key: key);
  final Candidate candidate;

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
    final mediaQuery = MediaQuery.of(context);
    const textStyle = TextStyle(fontSize: 20);
    return FutureBuilder<Candidate>(
      future: getFile(candidate),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: mediaQuery.size.width,
              child: const CircularProgressIndicator(),
            ),
          );
        }
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CandidateDetailPage(
                        candidate: snapshot.data!,
                      )),
            );
          },
          child: Column(
            children: [
              p.extension(snapshot.data?.filename as String) != '.docx'
                  ? Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: MemoryImage(base64Decode(
                                (snapshot.data?.filedata) as String)),
                          ),
                        ),
                      ),
                    )
                  : Image.asset('assets/word.png'),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    snapshot.data?.surname ?? '',
                    style: textStyle,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    snapshot.data?.name ?? '',
                    style: textStyle,
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                snapshot.data?.workname ?? '',
                style: textStyle,
              ),
              const SizedBox(height: 6),
              Text(
                snapshot.data?.section ?? '',
                style: textStyle,
              ),
              const SizedBox(height: 6),
              Text(
                p.extension(snapshot.data?.filename as String) ?? '',
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ),
        );
      },
    );
  }
}
