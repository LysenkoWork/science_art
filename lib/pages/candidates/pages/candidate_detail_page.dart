import 'dart:convert';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../model/candidate_model.dart';
import '../../../model/models.dart';
import '../../../repo/repositories.dart';
import '../../auth/services/auth_repository.dart';
import '../../dialog.dart';
import '../services/candidate_api_provider.dart';

class CandidateDetailPage extends StatefulWidget {
  CandidateDetailPage({Key? key, required this.candidate, this.user}) : super(key: key);
  final Candidate candidate;
  User? user;

  @override
  State<CandidateDetailPage> createState() => _CandidateDetailPageState();
}

class _CandidateDetailPageState extends State<CandidateDetailPage> {
  CandidateApiProvider candidateRepository = CandidateApiProvider();
  final _formKey = GlobalKey<FormBuilderState>();
  bool val = false;
  var stdValidator = FormBuilderValidators.compose([
    FormBuilderValidators.required(errorText: 'Обязательно для заполнения'),
    FormBuilderValidators.minLength(2, errorText: 'Слишком короткое'),
  ]);

  @override
  Widget build(BuildContext context) {
    final AuthRepository _authProvider = AuthRepository();
    int _value = 2;
    print(widget.candidate.assetsFileName);
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
      body: Column(
        children: [
          // widget.candidate.assetsFileName != null
          //     ? Container(
          //         height: 1000,
          //         decoration: BoxDecoration(
          //           image: DecorationImage(
          //               fit: BoxFit.fitHeight,
          //               image: AssetImage(
          //                   'assets/candidate_image/${widget.candidate.assetsFileName}')
          //               // image: MemoryImage(
          //               //   base64Decode((widget.candidate.filedata) as String),
          //               // ),
          //               ),
          //         ),
          //       )
          //     : Text(widget.candidate.assetsFileName),
          Text(widget.candidate.name!),
          SegmentedButton<int>(
            segments: [
              for (int index = 1; index <= 10; ++index)
                ButtonSegment<int>(
                  value: index,
                  label: Text('$index'),
                ),
            ],
            selected: <int>{_value},
            onSelectionChanged: (Set<int> newSelection) {
              setState(() {
                _value = newSelection.first;
              });
            },
          ),
                FutureBuilder(
                  future: candidateRepository.getRating(widget.candidate.id!, widget.user!.id!),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 20,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return Text(snapshot.data?.ballov ?? '');
                  },
                ),
          TextButton(
            onPressed: () {
              candidateRepository.addRating(
                '25',
                widget.user!.id!,
                '5',
              );
            },
            child: const Text('Выставить 5 баллов'),
          ),
        ],
      ),
    );
  }
}
