import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:science_art/pages/candidates/bloc/candidate_bloc.dart';
import 'package:science_art/pages/candidates/bloc/candidate_event.dart';
import 'package:science_art/pages/candidates/bloc/candidate_state.dart';
import '../../../app/theme/app_pallete.dart';
import '../../../model/candidate_model.dart';

class CandidatesList extends StatelessWidget {
  const CandidatesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CandidateBloc _candidateBloc =
        BlocProvider.of<CandidateBloc>(context);
    final mediaQuery = MediaQuery.of(context);
    return BlocBuilder<CandidateBloc, CandidateState>(
      builder: (context, state) {
        log(state.toString());
        if (state is CandidateEmptyState) {
          return const Text('Заявок пока нет');
        }
        if (state is CandidateLoadingState) {
          return const CircularProgressIndicator();
        }
        if (state is CandidateLoadedState) {
          return Padding(
            padding: EdgeInsets.only(
              left: mediaQuery.size.width / 15,
              right: mediaQuery.size.width / 15,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16),
                itemCount: 2,
                itemBuilder: (context, index) {
                  {
                    return itemCard(state.loadedCandidate[index], context);
                  }
                },
              ),
            ),
          );
        }
        if (state is CandidateErrorState) {
          return const Text('Ошибка!');
        }
        return const SizedBox();
      },
    );
    //return Padding(
    //  padding: EdgeInsets.only(
    //    left: mediaQuery.size.width / 15,
    //    right: mediaQuery.size.width / 15,
    //  ),
    //  child: GridView.builder(
    //    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //        crossAxisCount: 2, mainAxisSpacing: 16, crossAxisSpacing: 16),
    //    itemCount: 2,
    //    itemBuilder: (context, index) {
    //      {
    //        return itemCard(widget.candidate, context);
    //      }
    //    },
    //  ),
    //);
  }
}

/// ---------------------------------------------------------------------------------------------

Widget itemCard(Candidate candidate, BuildContext context) {
  final mediaQuery = MediaQuery.of(context);
  final timeTextStyle =
      TextStyle(fontSize: mediaQuery.size.width / 30, color: AppPallete.black8);

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
          //decoration: BoxDecoration(
          //  image: DecorationImage(
          //    fit: BoxFit.fitHeight,
          //    image: MemoryImage(base64Decode(candidate.filedata!)),
          //  ),
          //),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text(candidate.surname!),
                  Text(candidate.name!),
                ],
              ),
              Text(candidate.section!),
            ],
          ),
        ),
      ),
    ),
  );
}
