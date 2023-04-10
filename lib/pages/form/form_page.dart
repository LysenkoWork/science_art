import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../app/theme/app_pallete.dart';
import '../../model/candidate_model.dart';
import '../../model/models.dart';
import '/repo/repositories.dart';
import '/pages/dialog.dart';

class FormPage extends StatelessWidget {
  FormPage({Key? key, required this.candidate}) : super(key: key);
  Candidate candidate;
  CandidateRepository candidateRepository = CandidateRepository();

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, bottom: 10.0, top: 5.0),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: const [
                    Icon(
                      Icons.arrow_back_ios,
                      color: AppPallete.blue,
                    ),
                    Text(
                      'Назад',
                      style: TextStyle(
                        color: AppPallete.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(mediaQuery.size.width / 15),
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    FormBuilderTextField(
                      name: 'surname',
                      decoration: const InputDecoration(
                        labelText: 'Фамилия',
                      ),
                      onChanged: (value) {
                        candidate.surname = value;
                      },
                    ),
                    FormBuilderTextField(
                      name: 'name',
                      decoration: const InputDecoration(
                        labelText: 'Имя',
                      ),
                      onChanged: (value) {
                        candidate.name = value;
                      },
                    ),
                    FormBuilderTextField(
                      name: 'patronymic',
                      decoration: const InputDecoration(
                        labelText: 'Отчество',
                      ),
                      onChanged: (value) {
                        candidate.patronymic = value;
                      },
                    ),
                    candidate.ageCategory == age_categoryes_min[2]
                        ? FormBuilderTextField(
                            name: 'job',
                            decoration: const InputDecoration(
                              labelText: 'Место работы',
                            ),
                            onChanged: (value) {
                              candidate.job = value;
                            },
                          )
                        : const SizedBox(),
                    candidate.ageCategory != age_categoryes_min[2]
                        ? FormBuilderTextField(
                            name: 'leadership',
                            decoration: const InputDecoration(
                              labelText: 'Руководитель',
                            ),
                            onChanged: (value) {
                              candidate.leadership = value;
                            },
                          )
                        : const SizedBox(),
                    FormBuilderTextField(
                      name: 'email',
                      decoration: const InputDecoration(
                        labelText: 'Электронная почта',
                      ),
                      onChanged: (value) {
                        candidate.email = value;
                      },
                    ),
                    candidate.section == sectionsView[3]
                        ? FormBuilderDropdown<String>(
                            name: 'section',
                            decoration:
                                const InputDecoration(labelText: 'Секция'),
                            onChanged: (value) {
                              candidate.section = value;
                            },
                            items: childsection
                                .map((section) => DropdownMenuItem(
                                      alignment: AlignmentDirectional.center,
                                      value: section,
                                      child: Text(section),
                                    ))
                                .toList(),
                          )
                        : const SizedBox(),
                    candidate.section == sectionsView[0]
                        ? FormBuilderDropdown<String>(
                            name: 'section',
                            decoration:
                                const InputDecoration(labelText: 'Секция'),
                            onChanged: (value) {
                              candidate.section = value;
                            },
                            items: otherSection
                                .map((section) => DropdownMenuItem(
                                      alignment: AlignmentDirectional.center,
                                      value: section,
                                      child: Text(section),
                                    ))
                                .toList(),
                          )
                        : const SizedBox(),
                    FormBuilderTextField(
                      name: 'phoneNumber',
                      decoration: const InputDecoration(
                        labelText: 'Номер телефона',
                      ),
                      onChanged: (value) {
                        candidate.phoneNumber = value;
                      },
                    ),
                    SizedBox(height: mediaQuery.size.width / 15),
                    InkWell(
                      onTap: () {
                        try {
                          candidate.insertDate = DateTime.now().toString();
                          print(
                              '---------------- DateTime.now --------------------');
                          print(candidate.insertDate);
                          candidateRepository.add(candidate);
                          dialog(context, '', 'Заявка отправлена', 'Ok');
                        } catch (e) {
                          print(
                              '---------------- Error candidateRepository.add(candidate) --------------------');
                          print(e);
                          dialog(context, 'Ошибка', 'Не удалось подать заявку',
                              'Ok');
                        }
                      },
                      child: Container(
                        height: mediaQuery.size.width / 15,
                        width: mediaQuery.size.width / 4,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40)),
                          color: AppPallete.blue,
                        ),
                        child: Center(
                          child: Text(
                            'Подать заявку',
                            style: TextStyle(
                                fontSize: mediaQuery.size.width / 45,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
