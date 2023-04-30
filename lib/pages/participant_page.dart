import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../app/theme/app_pallete.dart';
import '../model/candidate_model.dart';
import 'package:file_picker/file_picker.dart';
import '/model/models.dart';

class ParticipantPage extends StatefulWidget {
  const ParticipantPage({Key? key}) : super(key: key);

  @override
  State<ParticipantPage> createState() => _ParticipantPageState();
}

class _ParticipantPageState extends State<ParticipantPage> {


  Future<List<Candidate>> getList() async {
    String url = 'http://science-art.pro/test07.php';
    final Response response = await get(Uri.parse(url));
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Candidate> candidates = items.map<Candidate>((json) {
      return Candidate.fromJson(json);
    }).toList();
    return candidates;
  }

  Future<int> getFile(Candidate candidate) async {
    String url = 'http://science-art.pro/test02.php';
//    final Response response = await post(Uri.parse(url), body: {
//      'id': candidate.id,
//    });
//    final Candidate c = Candidate.fromJson(json.decode(response.body));
/*
    String ext = p.extension(c.filename as String);
    if (ext == '.jpg' || ext == '.jpeg') {
      String filename = c.insertDate!.replaceAll(' ', '-');
      print(filename);
      filename = '/home/andrey/Pictures/' + filename + p.extension(c.filename as String);
      print(filename);
      File file = File(filename);
      file.create();
      file.writeAsBytes(base64Decode(c.filedata!));
    }
*/
//      return Candidate.fromJson(json.decode(response.body));
  return 1;
  }

  Future<List<Expert>> getListExpert() async {
    return experts;
  }

  Widget itemCard(Candidate candidate) {
    final mediaQuery = MediaQuery.of(context);
    final timeTextStyle = TextStyle(
        fontSize: mediaQuery.size.width / 30, color: AppPallete.black8);

    Future<void> save(Candidate candidate) async {
      String? outputFile = await FilePicker.platform.saveFile(
        dialogTitle: 'Сохранить файл как...',
        fileName: '/home/andrey/Pictures/' + candidate.insertDate!.replaceAll(' ', '-') + p.extension(candidate.filename as String),
//        fileName: candidate.filename
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

    return FutureBuilder<int>(
        future: getFile(candidate),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
//          print('http://science-art.pro/upload/' + candidate.insertDate!.replaceAll(' ', '-') + '.jpg');
          String ext = p.extension(candidate.filename as String);
          final String fname = 'http://science-art.pro/upload/${candidate.insertDate!.replaceAll(' ', '-')}$ext';

          return Card(
            color: AppPallete.black2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            child: InkWell(
              onTap: () {
//                print(snapshot.data?.filename);
//                print(p.extension(snapshot.data?.filename as String));
                save(snapshot.data as Candidate);
              },
              child: Container(

                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    //image: MemoryImage(base64Decode((snapshot.data?.filedata) as String)),
                      image: NetworkImage(fname),
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
                      child: Text('(snapshot.data?.name) as String)')),
                  ],
                ),
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
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 700,
                      childAspectRatio: 0.8,
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
