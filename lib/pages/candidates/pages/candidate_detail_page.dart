import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../model/candidate_model.dart';
import '../../dialog.dart';

class CandidateDetailPage extends StatefulWidget {
  const CandidateDetailPage({Key? key, required this.candidate})
      : super(key: key);
  final Candidate candidate;

  @override
  State<CandidateDetailPage> createState() => _CandidateDetailPageState();
}

class _CandidateDetailPageState extends State<CandidateDetailPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool val = false;
  var stdValidator = FormBuilderValidators.compose([
    FormBuilderValidators.required(errorText: 'Обязательно для заполнения'),
    FormBuilderValidators.minLength(2, errorText: 'Слишком короткое'),
  ]);

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(80.0),
        child: Center(
          child: Column(
            children: [
              Text(widget.candidate.name ?? ''),
              const SizedBox(height: 20),
              FormBuilder(
                key: _formKey,
                onChanged: () {
                  setState(() {
                    if (_formKey.currentState != null) {
                      val = _formKey.currentState!.isValid;
                    }
                  });
                },
                child: FormBuilderTextField(
                  name: 'score',
                  decoration: const InputDecoration(
                    labelText: 'Оценка',
                  ),
                  validator: stdValidator,
                  onChanged: (value) {
                    widget.candidate.surname = value;
                  },
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  if (val == true) {
                    try {
                      dialogForm(context, '', 'Заявка отправлена', 'Ok');
                    } catch (e) {
                      print(e);
                      dialog(
                          context, 'Ошибка', 'Не удалось подать заявку', 'Ok');
                    }
                  } else {
                    dialog(context, '', 'Заполните все поля', 'Ok');
                  }
                },
                child: const Text('Отправить оценку'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
