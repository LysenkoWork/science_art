import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../app/theme/app_pallete.dart';
import '../../model/candidate_model.dart';
import 'package:file_picker/file_picker.dart';
import '/model/models.dart';

class ParticipantPageOld extends StatefulWidget {
  const ParticipantPageOld({Key? key}) : super(key: key);

  @override
  State<ParticipantPageOld> createState() => _ParticipantPageOldState();
}

class _ParticipantPageOldState extends State<ParticipantPageOld> {
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

  Future<List<Expert>> getListExpert() async {
    return experts;
  }

  Widget itemCard(Candidate candidate) {
    final mediaQuery = MediaQuery.of(context);
    final timeTextStyle = TextStyle(
        fontSize: mediaQuery.size.width / 30, color: AppPallete.black8);

    Future<void> save() async {
      String? outputFile = await FilePicker.platform.saveFile(
        dialogTitle: 'Сохранить файл как...',
        fileName: candidate.filename,
      );

      if (outputFile != null) {
        print('----------==============-----------++++++++++++');
        print(outputFile);
        try {
          File file = File(outputFile);
          file.create();
          file.writeAsBytes(base64Decode(candidate.filedata!));
        } catch (e) {
          print('----------------------------');
          print(e);
        }
      }
    }

    return FutureBuilder<Candidate>(
        future: getFile(candidate),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          return Card(
            color: AppPallete.black2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            child: Container(

              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: MemoryImage(base64Decode((snapshot.data?.filedata) as String)),
                ),
                borderRadius: BorderRadius.circular(50),
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    color: const Color.fromRGBO(0, 0, 0, 0.5),
                    height: 10,
                    width: mediaQuery.size.width,
                    child: Text((snapshot.data?.name) as String)),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        body: FutureBuilder<List<Candidate>>(
            future: getList(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const CircularProgressIndicator();
              return LayoutBuilder(builder: (context, constraints) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: mediaQuery.size.width / 15,
                    right: mediaQuery.size.width / 15,
                  ),
                  child: GridView.builder(
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 1,
                    ),
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return itemCard(snapshot.data![index]);
                    },
                  ),
                );
              });
            }));
  }
}
