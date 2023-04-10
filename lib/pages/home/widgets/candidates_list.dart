import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../../app/theme/app_pallete.dart';
import '../../../model/candidate_model.dart';

class CandidatesList extends StatefulWidget {
  const CandidatesList({Key? key}) : super(key: key);

  @override
  State<CandidatesList> createState() => _CandidatesListState();
}

class _CandidatesListState extends State<CandidatesList> {
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
      child: Card(
        color: AppPallete.black2,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              candidate.name.toString(),
              style: timeTextStyle,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              candidate.surname.toString(),
              style: timeTextStyle,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              candidate.patronymic.toString(),
              style: timeTextStyle,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              candidate.ageCategory.toString(),
              style: timeTextStyle,
            ),
          ],
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
                  //gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //  crossAxisCount: 2,
                  //),
                  itemBuilder: (context, index) {
                    return CandidateCard(snapshot.data![index]);
                    //return Card(
                    //  child: Column(
                    //    children: [
                    //      Row(
                    //        children: [
                    //          Text('${snapshot.data?[index].ageCategory}'),
                    //          const SizedBox(
                    //            width: 10,
                    //          ),
                    //          Text('${snapshot.data?[index].section}'),
                    //        ],
                    //      ),
                    //      Row(
                    //        children: [
                    //          Text('${snapshot.data?[index].name}'),
                    //          const SizedBox(
                    //            width: 10,
                    //          ),
                    //          Text('${snapshot.data?[index].surname}'),
                    //        ],
                    //      ),
                    //      Row(
                    //        children: [
                    //          Text('${snapshot.data?[index].insertDate}'),
                    //        ],
                    //      ),
                    //    ],
                    //  ),
                    //);
                  },
                  itemCount: snapshot.data?.length,
                ),
              );
            }));
  }
}
