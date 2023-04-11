import 'package:form_builder_validators/form_builder_validators.dart';
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

var stdValidator = FormBuilderValidators.compose([
  FormBuilderValidators.required(errorText: 'Обязательно для заполнения'),
  FormBuilderValidators.minLength(2, errorText: 'Слишком короткое'),
]);

class FormPage extends StatefulWidget {
  FormPage({Key? key, required this.candidate, this.sectionClass}) : super(key: key);
  Candidate candidate;
  String? sectionClass;

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  CandidateRepository candidateRepository = CandidateRepository();

  final _formKey = GlobalKey<FormBuilderState>();
  PlatformFile? file;
  bool val = false;

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
                onChanged: () {
                  setState(() {
                    if (_formKey.currentState != null) {
                      val = _formKey.currentState!.isValid;
                    }
                  });
                },
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  children: [
                    FormBuilderTextField(
                      name: 'surname',
                      decoration: const InputDecoration(
                        labelText: 'Фамилия',
                      ),
                      validator: stdValidator,
                      onChanged: (value) {
                        widget.candidate.surname = value;
                      },
                    ),
                    FormBuilderTextField(
                      name: 'name',
                      decoration: const InputDecoration(
                        labelText: 'Имя',
                      ),
                      validator: stdValidator,
                      onChanged: (value) {
                        widget.candidate.name = value;
                      },
                    ),
                    FormBuilderTextField(
                      name: 'patronymic',
                      decoration: const InputDecoration(
                        labelText: 'Отчество',
                      ),
                      validator: stdValidator,
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
                            validator: stdValidator,
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
                            validator: stdValidator,
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
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: 'Обязательно для заполнения'),
                        FormBuilderValidators.email(
                            errorText: 'Введите адрес электронной почты')
                      ]),
                      onChanged: (value) {
                        widget.candidate.email = value;
                      },
                    ),
                    widget.sectionClass == 'Взрослый список'
                        ? FormBuilderDropdown<String>(
                            name: 'section',
                            decoration:
                                const InputDecoration(labelText: 'Секция'),
                            onChanged: (value) {
                              widget.candidate.section = value;
                            },
                            validator: stdValidator,
                            items: childsection
                                .map((section) => DropdownMenuItem(
                                      alignment: AlignmentDirectional.center,
                                      value: section,
                                      child: Text(section),
                                    ))
                                .toList(),
                          )
                        : const SizedBox(),
                    widget.sectionClass == 'Детский список'
                        ? FormBuilderDropdown<String>(
                            name: 'section',
                            decoration:
                                const InputDecoration(labelText: 'Секция'),
                            onChanged: (value) {
                              widget.candidate.section = value;
                            },
                            validator: stdValidator,
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
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Номер телефона',
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: 'Обязательно для заполнения'),
                        FormBuilderValidators.numeric(
                            errorText: 'Введите номер телефона')
                      ]),
                      onChanged: (value) {
                        widget.candidate.phoneNumber = value;
                      },
                    ),
                    FormBuilderTextField(
                      name: 'workname',
                      decoration: const InputDecoration(
                        labelText: 'Название работы',
                      ),
                      validator: stdValidator,
                      onChanged: (value) {
                        widget.candidate.workname = value;
                      },
                    ),
                    SizedBox(height: mediaQuery.size.width / 25),
                    widget.candidate.filename != ''
                        ? Text(widget.candidate.filename!)
                        : const Text(
                            'Файл не загружен',
                            style: TextStyle(color: Colors.redAccent),
                          ),
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
                        child: Text(
                          ((widget.candidate.section! == sectionOptions[0]) ||
                                  (widget.candidate.section! ==
                                      sectionOptions[1]))
                              ? 'Выберите файл Word'
                              : 'Выберите файл JPG',
                        )),
                    SizedBox(height: mediaQuery.size.width / 30),
                    InkWell(
                      onTap: () {
                        if (val == true &&
                            widget.candidate.filename?.length != 0) {
                          try {
                            widget.candidate.insertDate =
                                DateTime.now().toString();
                            print(
                                '---------------- DateTime.now --------------------');
                            print(widget.candidate.insertDate);
                            candidateRepository.add(widget.candidate);

                            dialogForm(context, '', 'Заявка отправлена', 'Ok');
                          } catch (e) {
                            print(
                                '---------------- Error candidateRepository.add(candidate) --------------------');
                            print(e);
                            dialog(context, 'Ошибка',
                                'Не удалось подать заявку', 'Ok');
                          }
                        } else {
                          dialog(context, '', 'Заполните все поля', 'Ok');
                        }
                      },
                      child: Container(
                        height: mediaQuery.size.width / 15,
                        width: mediaQuery.size.width / 4,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40)),
                          color: val ? AppPallete.blue : AppPallete.black4,
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
