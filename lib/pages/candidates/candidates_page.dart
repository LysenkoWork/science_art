import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:file_picker/file_picker.dart';
import 'package:science_art/pages/candidates/bloc/candidate_bloc.dart';
import 'package:science_art/pages/candidates/bloc/candidate_event.dart';
import 'package:science_art/pages/candidates/services/candidate_repository.dart';
import 'package:science_art/pages/candidates/widgets/candidates_list.dart';
import '../../app/theme/app_pallete.dart';
import '../../model/candidate_model.dart';
import '../../model/models.dart';
import 'bloc/candidate_state.dart';

class CandidatePage extends StatelessWidget {
  const CandidatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    Candidate candidate = Candidate();
    print('Старт билдера');
    return RepositoryProvider(
      create: (context) => CandidateRepository(),
      child: BlocProvider(
        create: (context) => CandidateBloc(
            candidateRepository: context.read<CandidateRepository>())
          ..add(CandidateLoadEvent()),
        child: Scaffold(
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
          body: BlocBuilder<CandidateBloc, CandidateState>(
            builder: (context, state) {
              print('Старт1421ра');
              if (state is CandidateEmptyState) {
                return const Text('Заявок пока нет');
              }
              if (state is CandidateLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is CandidateLoadedState) {
                return CandidatesList(
                  candidates: state.loadedCandidates,
                );
                //return Text(state.loadedCandidate[2].name.toString());
              }
              return const SizedBox();
            },
          ),
          //body: const CandidatesList(),
        ),
      ),
    );
  }
}

class CandidatePageIII extends StatefulWidget {
  const CandidatePageIII({Key? key}) : super(key: key);

  @override
  State<CandidatePageIII> createState() => _CandidatePageIIIState();
}

class _CandidatePageIIIState extends State<CandidatePageIII> {
  Future<List<Candidate>> getList() async {
    String url = 'http://science-art.pro/test03.php';
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

    Future<void>? prinT(String filename) {
      print(filename);
      return null;
    }

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: InkWell(
          onTap: () {
            save();
            prinT(candidate!.filename.toString());
          },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: MemoryImage(base64Decode(candidate.filedata!)),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  color: const Color.fromRGBO(0, 0, 0, 0.5),
                  height: 10,
                  width: mediaQuery.size.width,
                  child: Text(candidate.section!),
                )
              ],
            ),
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16),
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        if (snapshot.data![index].section != "АРТ-РЕПОРТАЖ" &&
                            snapshot.data![index].section != "IT В ИСКУССТВЕ") {
                          return itemCard(snapshot.data![index]);
                        }
                      },
                    ),
                  ),
                );
              });
            }));
  }
}
