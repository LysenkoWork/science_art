import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../model/candidate_model.dart';
import '../../../model/models.dart';
import '../../auth/services/auth_repository.dart';
import '../../dialog.dart';

class CandidateDetailPage extends StatefulWidget {
  CandidateDetailPage({Key? key, required this.candidate, this.user})
      : super(key: key);
  final Candidate candidate;
  User? user;

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
    final AuthRepository _authProvider = AuthRepository();
    String? score;
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
        child: widget.user != null
            ? Center(
                child: Column(
                  children: [
                    Text(widget.candidate.name ?? ''),
                    Text(widget.candidate.id ?? ''),
                    Text(widget.user?.id ?? ''),
                    Text(widget.user?.name ?? ''),
                    Text(widget.user?.pass ?? ''),

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
                          score = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        if (val == true) {
                          try {
                            _authProvider.addReiting(
                                cid: widget.candidate!.id!,
                                uid: widget.user!.id!,
                                ballov: score!);
                            dialogForm(context, '', 'Заявка отправлена', 'Ok');
                          } catch (e) {
                            print(e);
                            dialog(context, e.toString(),
                                'Не удалось подать заявку', 'Ok');
                          }
                        } else {
                          dialog(context, '', 'Заполните все поля', 'Ok');
                        }
                      },
                      child: const Text('Отправить оценку'),
                    ),
                  ],
                ),
              )
            : const Text('Вы не авторизованы'),
      ),
    );
  }
}
