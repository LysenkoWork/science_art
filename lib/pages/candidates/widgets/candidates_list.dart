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
  const CandidatesList({Key? key, required this.candidates}) : super(key: key);
  final List<Candidate> candidates;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.only(
        left: 150,
        right: 150,
      ),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: candidates.length,
        itemBuilder: (context, index) {
          {
            return itemCard(candidates[index], context);
          }
        },
      ),
    );
    ;
  }
}

/// ---------------------------------------------------------------------------------------------

Widget itemCard(Candidate candidate, BuildContext context) {
  final mediaQuery = MediaQuery.of(context);

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
