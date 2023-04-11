import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../app/theme/app_pallete.dart';
import '../model/candidate_model.dart';
import 'package:file_picker/file_picker.dart';
import '../model/models.dart';

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

  Future<List<Expert>> getListExpert() async {
    return experts;
  }

  Widget itemCard(Candidate candidate) {
    final mediaQuery = MediaQuery.of(context);
    final timeTextStyle = TextStyle(
        fontSize: mediaQuery.size.width / 30, color: AppPallete.black8);

    return InkWell(
      onTap: () {
        try {
          File file = File('C://tmp/${candidate.filename}');
          file.create();
          file.writeAsBytes(base64Decode(candidate.filedata!));
        } catch (e) {
          print('----------------------------');
          print(e);
        }
      },
      child: Card(
        color: AppPallete.black2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: MemoryImage(base64Decode(candidate.filedata!)),
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
                child: Text(candidate.name!),
              )
            ],
          ),
        ),
      ),
    );
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
                      maxCrossAxisExtent: 300,
                      childAspectRatio: 0.7,
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
