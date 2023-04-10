import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../app/theme/app_pallete.dart';
import '../model/candidate_model.dart';
import 'package:file_picker/file_picker.dart';

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

  Widget CandidateCard(Candidate candidate) {
    final mediaQuery = MediaQuery.of(context);
    final timeTextStyle = TextStyle(
        fontSize: mediaQuery.size.width / 30, color: AppPallete.black8);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () async {
          final FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['jpg', 'doc', 'docx'],

//            onFileLoading: (status) {},
          );
          if (result != null) {
            print('-------------------------------------');
            PlatformFile file = result.files.single;
            print(file.name);
            print(file.size);
            print(file.bytes);
            print('-------------------------------------');
            String baseimage = base64Encode(file.bytes as List<int>);
            print(baseimage);
            print('-------------------------------------');
            List<int> l = base64Decode(baseimage);
            print(l);

//            print('File Path: ${file.readStream}');
//            print('File Path: ${file.bytes}');
//            print('File Path: ${file.path}');
          }
        },
        child: Card(
          color: AppPallete.black2,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    candidate.name.toString(),
                    style: timeTextStyle,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    candidate.surname.toString(),
                    style: timeTextStyle,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                candidate.section.toString(),
                style: timeTextStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                candidate.ageCategory.toString(),
                style: timeTextStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                candidate.insertDate.toString(),
                style: timeTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    //final simpleText = TextStyle(fontSize: mediaQuery.size.width / 60);
    return Scaffold(
        body: FutureBuilder<List<Candidate>>(
            future: getList(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const CircularProgressIndicator();
              return Center(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: mediaQuery.size.width / 2,
                    mainAxisExtent: mediaQuery.size.width / 3,
                  ),
                  itemBuilder: (context, index) {
                    return CandidateCard(snapshot.data![index]);
                  },
                  itemCount: snapshot.data?.length,
                ),
              );
            }));
  }
}
