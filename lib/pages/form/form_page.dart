import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../app/theme/app_pallete.dart';
import '../../model/candidate_model.dart';
import '../../model/models.dart';
import '/repo/repositories.dart';
import '/pages/dialog.dart';
import 'package:file_picker/file_picker.dart';

class FormPage extends StatefulWidget {
  FormPage({Key? key, required this.candidate}) : super(key: key);
  Candidate candidate;

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  CandidateRepository candidateRepository = CandidateRepository();

  final _formKey = GlobalKey<FormBuilderState>();
  PlatformFile? file;

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
                        widget.candidate.surname = value;
                      },
                    ),
                    FormBuilderTextField(
                      name: 'name',
                      decoration: const InputDecoration(
                        labelText: 'Имя',
                      ),
                      onChanged: (value) {
                        widget.candidate.name = value;
                      },
                    ),
                    FormBuilderTextField(
                      name: 'patronymic',
                      decoration: const InputDecoration(
                        labelText: 'Отчество',
                      ),
                      onChanged: (value) {
                        widget.candidate.patronymic = value;
                      },
                    ),
                    widget.candidate.ageCategory == age_categoryes_min[2]
                        ? FormBuilderTextField(
                            name: 'job',
                            decoration: const InputDecoration(
                              labelText: 'Место работы',
                            ),
                            onChanged: (value) {
                              widget.candidate.job = value;
                            },
                          )
                        : const SizedBox(),
                    widget.candidate.ageCategory != age_categoryes_min[2]
                        ? FormBuilderTextField(
                            name: 'leadership',
                            decoration: const InputDecoration(
                              labelText: 'Руководитель',
                            ),
                            onChanged: (value) {
                              widget.candidate.leadership = value;
                            },
                          )
                        : const SizedBox(),
                    FormBuilderTextField(
                      name: 'email',
                      decoration: const InputDecoration(
                        labelText: 'Электронная почта',
                      ),
                      onChanged: (value) {
                        widget.candidate.email = value;
                      },
                    ),
                    widget.candidate.section == sectionsView[3]
                        ? FormBuilderDropdown<String>(
                            name: 'section',
                            decoration:
                                const InputDecoration(labelText: 'Секция'),
                            onChanged: (value) {
                              widget.candidate.section = value;
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
                    widget.candidate.section == sectionsView[0]
                        ? FormBuilderDropdown<String>(
                            name: 'section',
                            decoration:
                                const InputDecoration(labelText: 'Секция'),
                            onChanged: (value) {
                              widget.candidate.section = value;
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
                      initialValue: sectionOptions[0],
                      decoration: const InputDecoration(
                        labelText: 'Номер телефона',
                      ),
                      onChanged: (value) {
                        widget.candidate.phoneNumber = value;
                      },
                    ),
                    FormBuilderTextField(
                      name: 'workname',
                      initialValue: widget.candidate.section,
                      decoration: const InputDecoration(
                        labelText: 'Название работы',
                      ),
                      onChanged: (value) {
                        widget.candidate.workname = value;
                      },
                    ),
/*                    FormBuilderTextField(
                      name: 'filename',
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Файл',
                      ),
                      onChanged: (value) {
                        widget.candidate.filename = value;
                      },
                    ),
 */
                    SizedBox(height: mediaQuery.size.width / 25),
                    Text(widget.candidate.filename!),
                    SizedBox(height: mediaQuery.size.width / 25),
                    TextButton(
                        onPressed: () async {
                          final FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ((widget.candidate.section! ==
                                        sectionOptions[0]) ||
                                    (widget.candidate.section! ==
                                        sectionOptions[1]))
                                ? allowedExtDOC
                                : allowedExtJPG,
//            onFileLoading: (status) {},
                          );
                          if (result != null) {
                            file = result.files.single;
                            setState(() {
                              widget.candidate.filename = file?.name;
                              widget.candidate.filedata =
                                  base64Encode(file?.bytes as Uint8List);
                              widget.candidate.filesize =
                                  widget.candidate.filedata?.length.toString();
//                              _formKey.currentState?.fields['filename']?.setValue(file?.name);
                            });
                          }
                        },
                        child: const Text('Выбирите файл')),
                    SizedBox(height: mediaQuery.size.width / 30),
                    InkWell(
                      onTap: () {
                        try {
                          widget.candidate.insertDate =
                              DateTime.now().toString();
                          print(
                              '---------------- DateTime.now --------------------');
                          print(widget.candidate.insertDate);
                          candidateRepository.add(widget.candidate);
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
