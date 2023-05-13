import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:science_art/pages/candidates/pages/candidate_detail_page.dart';
import 'package:science_art/pages/candidates/pages/candidate_detail_page_new.dart';
import 'package:science_art/pages/candidates/services/candidate_api_provider.dart';
import '../../../model/candidate_model.dart';
import '../../../model/models.dart';
import 'package:path/path.dart' as p;
import 'dart:io' show File, Platform;
import 'package:flutter/foundation.dart';

class CandidateCard extends StatefulWidget {
  CandidateCard({
    Key? key,
    required this.candidate,
    this.user,
  }) : super(key: key);
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

  Future<void> save(String? filedata) async {
    String? outputFile = await FilePicker.platform.saveFile(
      dialogTitle: 'Сохранить файл как...',
      fileName: widget.candidate.filename,
    );

    if (outputFile != null) {
      print('----------==============-----------++++++++++++');
      print(outputFile);
      try {
        File file = File(outputFile);
        file.create();
        file.writeAsBytes(base64Decode(filedata!));
      } catch (e) {
        print('----------------------------');
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    const textStyle = TextStyle(fontSize: 20);
    CandidateApiProvider candidateRepository = CandidateApiProvider();
    if (widget.user != null) {
      return FutureBuilder(
        future: candidateRepository.getRating(widget.candidate.id!, widget.user!.id!),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                width: 20,
                child: CircularProgressIndicator(),
              ),
            );
          }

          return InkWell(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => CandidateDetailPage(
              //       candidate: widget.candidate,
              //       user: widget.user,
              //     ),
              //   ),
              // );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CandidateDetailPageNew(
                    candidate: widget.candidate,
                    user: widget.user,
                    ballov: snapshot.data?.ballov ?? '0',
                  ),
                ),
              );
            },
            child: Column(
              children: [
                p.extension(widget.candidate.filename as String) != '.docx'
                    ? Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: AssetImage(
                                    'assets/candidate_image/${widget.candidate.assetsFileName}')
                                // image: MemoryImage(
                                //   base64Decode((widget.candidate.filedata) as String),
                                // ),
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
                const SizedBox(height: 6),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.candidate.surname ?? '',
                          style: textStyle,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          widget.candidate.name ?? '',
                          style: textStyle,
                        ),
                      ],
                    ),
                    Text(
                      widget.candidate.workname ?? '',
                      style: textStyle,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.candidate.section ?? '',
                      style: textStyle,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.candidate.ageCategory ?? '',
                      style: textStyle,
                    ),
                    const SizedBox(height: 6),
                    if (snapshot.data?.ballov != null && snapshot.data?.ballov != 0)
                      Text(
                        'Ваша оценка: ${snapshot.data!.ballov!} баллов',
                        style: textStyle.copyWith(fontWeight: FontWeight.w600),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                widget.user?.name == 'admin'
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            if (widget.candidate != null) {
                              deleteCandidate(widget.candidate);
                            }
                          });
                        },
                        icon: const Icon(Icons.delete),
                      )
                    : const SizedBox(),
              ],
            ),
          );
        },
      );
    } else {
      return InkWell(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => CandidateDetailPage(
          //       candidate: widget.candidate,
          //       user: widget.user,
          //     ),
          //   ),
          // );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CandidateDetailPageNew(
                candidate: widget.candidate,
                user: widget.user,
              ),
            ),
          );
        },
        child: Column(
          children: [
            p.extension(widget.candidate.filename as String) != '.docx'
                ? Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: AssetImage(
                                'assets/candidate_image/${widget.candidate.assetsFileName}')
                            // image: MemoryImage(
                            //   base64Decode((widget.candidate.filedata) as String),
                            // ),
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
            const SizedBox(height: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.candidate.surname ?? '',
                      style: textStyle,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      widget.candidate.name ?? '',
                      style: textStyle,
                    ),
                  ],
                ),
                Text(
                  widget.candidate.workname ?? '',
                  style: textStyle,
                ),
                const SizedBox(height: 6),
                Text(
                  widget.candidate.section ?? '',
                  style: textStyle,
                ),
                const SizedBox(height: 6),
                Text(
                  widget.candidate.ageCategory ?? '',
                  style: textStyle,
                ),
              ],
            ),
            const SizedBox(height: 6),
            widget.user?.name == 'admin'
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        if (widget.candidate != null) {
                          deleteCandidate(widget.candidate);
                        }
                      });
                    },
                    icon: const Icon(Icons.delete),
                  )
                : const SizedBox(),
          ],
        ),
      );
    }
  }
}
