import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:science_art/app/theme/app_pallete.dart';
import 'package:science_art/model/candidate_model.dart';
import 'package:science_art/pages/candidates/pages/candidate_detail_page_new.dart';
import 'package:science_art/pages/reiting/model/reiting_model.dart';

class ReitingPage extends StatefulWidget {
  const ReitingPage({Key? key}) : super(key: key);

  @override
  State<ReitingPage> createState() => _ReitingPageState();
}

class _ReitingPageState extends State<ReitingPage> with TickerProviderStateMixin {
  late final TabController _tabControllerAge;
  late final TabController _tabControllerSection;
  int ageIndex = 0;
  int sectionIndex = 6;
  final List<String> ageCategory = [
    'Профессионалы',
    'Студенты',
    'Дети',
  ];
  final List<String> sections = [
    'ПАННО',
    'АРТ-ОБЪЕКТ',
    'АРТ-РЕПОРТАЖ',
    'РИСОВАНИЕ В VR',
    'ФОТОГРАФИКА',
    'ФОТОГРАФИЯ',
    'ХОЛСТ',
    'ИЛЛЮСТРАЦИЯ',
    'ЖИВОПИСЬ',
    'ВИДЕО-АНИМАЦИЯ',
    'ГРАФИКА',
  ];

  @override
  void initState() {
    super.initState();
    _tabControllerAge = TabController(
      length: ageCategory.length,
      vsync: this,
      initialIndex: ageIndex,
    );
    _tabControllerSection = TabController(
      length: sections.length,
      vsync: this,
      initialIndex: sectionIndex,
    );
  }

  @override
  void dispose() {
    _tabControllerAge.dispose();
    _tabControllerSection.dispose();
    super.dispose();
  }

  Future<List<ReitingModel>> getReitings(String age_categor, String section) async {
    String url = 'http://science-art.pro/prisers.php';
    Response response = await post(Uri.parse(url), body: {
      'age_category': age_categor,
      'section': section,
    });
    print(age_categor);
    print(section);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      final List<ReitingModel> res = result.map((e) => ReitingModel.fromJson(e)).toList();
      return res;
    } else {
      return [];
    }
  }

  Future<Candidate> getFile(String cid) async {
    String url = 'http://science-art.pro/test02.php';
    final Response response = await post(Uri.parse(url), body: {
      'id': cid,
    });
//    final Candidate candidate = Candidate.fromJson(json.decode(response.body));
    return Candidate.fromJson(json.decode(response.body));
  }

  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  @override
  Widget build(BuildContext context) {
    const timeTextStyle = TextStyle(fontSize: 30, color: Colors.black);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Рейтинг'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: Column(
            children: [
              TabBar(
                controller: _tabControllerAge,
                tabs: <Widget>[
                  for (String value in ageCategory)
                    Tab(
                      text: value,
                    ),
                ],
                onTap: (value) {
                  setState(() {
                    ageIndex = value;
                  });
                },
              ),
              TabBar(
                controller: _tabControllerSection,
                tabs: <Widget>[
                  for (String value in sections)
                    Tab(
                      text: value,
                    ),
                ],
                onTap: (value) {
                  setState(() {
                    sectionIndex = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder<List<ReitingModel>>(
          future: getReitings(
            ageCategory[ageIndex],
            sections[sectionIndex],
          ),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
            return Padding(
              padding: const EdgeInsets.only(
                left: 80.0,
                right: 220.0,
              ),
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                        '${snapshot.data![index].surname!} ${snapshot.data![index].name!} ${snapshot.data![index].patronymic!}',
                        style: timeTextStyle,
                      ),
                      subtitle: Text(
                        snapshot.data![index].workname!,
                        style: timeTextStyle.copyWith(color: AppPallete.black7),
                      ),
                      trailing: Text(
                        snapshot.data![index].ballov!,
                        style: timeTextStyle,
                      ),
                      leading: Text(
                        (index + 1).toString(),
                        style: timeTextStyle.copyWith(
                          fontSize: 40,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CandidateDetailPageNew(
                              candidate: Candidate(
                                id: snapshot.data![index].cid,
                                name: snapshot.data![index].name,
                                surname: snapshot.data![index].surname,
                                workname: snapshot.data![index].workname,
                                ageCategory: ageCategory[ageIndex] ?? '',
                                job: '',
                                email: '',
                                section: sections[sectionIndex] ?? '',
                                phoneNumber: '',
                                leadership: '',
                                insertDate: snapshot.data![index].insertDate,
                                description: '',
                                updateDate: '',
                                filename: snapshot.data![index].filename,
                                filesize: '',
                                filedata: '',
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
            );
          }),
      // body: Column(
      //   children: [
      //     FutureBuilder<List<ReitingModel>>(
      //       future: getReitings(
      //         ageCategory[ageIndex],
      //         sections[sectionIndex],
      //       ),
      //       builder: (context, snapshot) {
      //         if (!snapshot.hasData) return const CircularProgressIndicator();
      //         if (snapshot.hasError) return Text(snapshot.error.toString());
      //         return ListView.builder(
      //           itemCount: 5,
      //           itemBuilder: (BuildContext context, int index) {
      //             ListTile(title: Text('afafa'),);
      //           },
      //         );
      //       },
      //     ),
      //   ],
      // ),
    );
  }
}
