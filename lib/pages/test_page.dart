import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../app/theme/app_pallete.dart';
import '../model/candidate_model.dart';
import 'package:file_picker/file_picker.dart';

import '../model/models.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
//  CandidateRepository candidateRepository = CandidateRepository();

  Future<List<Candidate>> getList() async {
    String url = 'http://science-art.pro/test07.php';
    final Response response = await get(Uri.parse(url));
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Candidate> candidates = items.map<Candidate>((json) {
      return Candidate.fromJson(json);
    }).toList();
    return candidates;
  }

  Future<List<Expert>> getListExpert() async {
    return experts;
  }

  Widget itemCard(Expert expert) {
    final mediaQuery = MediaQuery.of(context);
    final timeTextStyle = TextStyle(
        fontSize: mediaQuery.size.width / 30, color: AppPallete.black8);
    //candidate.filedata ='';
    return InkWell(
      onTap: () {
        //File file = F
        //file.create();
      },
      //onTap: () async {
      //  final FilePickerResult? result = await FilePicker.platform.pickFiles(
      //    type: FileType.custom,
      //    allowedExtensions: ['jpg', 'doc', 'docx'],
//
//      //      onFileLoading: (status) {},
      //  );
      //  if (result != null) {
      //    print('-------------------------------------');
      //    PlatformFile file = result.files.single;
      //    print(file.name);
      //    print(file.size);
      //    print(file.bytes);
      //    print('-------------------------------------');
      //    String baseimage = base64Encode(file.bytes as List<int>);
      //    print(baseimage);
      //    print('-------------------------------------');
      //    List<int> l = base64Decode(baseimage);
      //    print(l);
//
//      //      print('File Path: ${file.readStream}');
//      //      print('File Path: ${file.bytes}');
//      //      print('File Path: ${file.path}');
      //  }
      //},
      child: Card(
        color: AppPallete.black2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
        ),
        child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: AssetImage(expert.photo!)
                ),

              ),
            ),
/*            Text(expert.name!),
            const SizedBox(
              height: 10,
            ),
            Text(expert.job!),

 */
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    //final simpleText = TextStyle(fontSize: mediaQuery.size.width / 60);
    return Scaffold(
        body: FutureBuilder<List<Expert>>(
            future: getListExpert(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const CircularProgressIndicator();
              return LayoutBuilder(builder: (context, constraints) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return itemCard(snapshot.data![index]);
                  },
                );
              });
            }));
  }
}
