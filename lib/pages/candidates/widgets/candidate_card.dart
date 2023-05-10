import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:science_art/pages/dialog.dart';
import '../../../model/candidate_model.dart';
import '../../../model/models.dart';
import '../pages/candidate_detail_page.dart';
import 'package:path/path.dart' as p;
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';

class CandidateCard extends StatefulWidget {
  CandidateCard({Key? key, required this.candidate, this.user})
      : super(key: key);
  final Candidate candidate;
  User? user;

  @override
  State<CandidateCard> createState() => _CandidateCardState();
}

class _CandidateCardState extends State<CandidateCard> {
  Future<Candidate> getFile(Candidate candidate) async {
    String url = 'http://science-art.pro/test02.php';
    final Response response = await post(Uri.parse(url), body: {
      'id': candidate.id,
    });
//    final Candidate candidate = Candidate.fromJson(json.decode(response.body));
    return Candidate.fromJson(json.decode(response.body));
  }

  Future<Candidate?> deleteCandidate(Candidate? candidate) async {
    String url = 'http://science-art.pro/delcan.php';
    final Response response = await post(Uri.parse(url), body: {
      'id': candidate!.id,
    });
    return null;
  }

Future<void> saveFile(String outputFile, String filedata) async {
  try {
    File file = File(outputFile);
    file.create();
    file.writeAsBytes(base64Decode(filedata));
  } catch (e) {
    print('----------------------------');
    print(e);
  }
}

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    const textStyle = TextStyle(fontSize: 20);

    return FutureBuilder<Candidate>(
      future: getFile(widget.candidate),
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
        final String filename = (snapshot.data?.insertDate as String) + (p.extension(snapshot.data?.filename as String));
        saveFile('/home/andrey/Pictures/$filename',
          snapshot.data?.filedata as String,);
        return Column(
          children: [
            p.extension(snapshot.data?.filename as String) != '.docx'
                ? Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: MemoryImage(
                            base64Decode((snapshot.data?.filedata) as String),
                          ),
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: SizedBox(
                      height: mediaQuery.size.height,
                      child: Image.asset('assets/word.png'),
                    ),
                  ),
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
              snapshot.data?.ageCategory ?? '',
              style: textStyle,
            ),
            const SizedBox(height: 6),
            //Text(
            //  p.extension(snapshot.data?.filename as String) ?? '',
            //  style: const TextStyle(color: Colors.red),
            //),
            widget.user != null
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        if (snapshot.data != null) {
                          deleteCandidate(snapshot?.data);
                        }
                      });
                    },
                    icon: const Icon(Icons.delete))
                : const SizedBox(),
          ],
        );
      },
    );
  }
}
