import 'package:flutter/material.dart';
import '/pages/form/views/sections_view.dart';

import '../../../app/theme/app_pallete.dart';
import '../../../model/candidate_model.dart';
import '../../../model/models.dart';
import '../widgets/AgeButtonWidget.dart';

class AgeView extends StatelessWidget {
  AgeView({Key? key}) : super(key: key);
  Candidate candidate = Candidate(
    id: '',
    name: '',
    surname: '',
    patronymic: '',
    ageCategory: '',
    job: '',
    email: '',
    section: '',
    phoneNumber: '',
    leadership: '',
    insertDate: '',
    description: '',
    updateDate: '',
    filename: '',
    filedata: '',
  );

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final headTextStyle = TextStyle(fontSize: mediaQuery.size.width / 40);
    return Scaffold(
      body: Column(
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
                    'На главную',
                    style: TextStyle(
                      color: AppPallete.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: AppPallete.black10,
                    height: MediaQuery.of(context).size.width / 300,
                    width: MediaQuery.of(context).size.width / 5.5,
                  ),
                  const SizedBox(width: 30),
                  Text(
                    'ВОЗРАСТНЫЕ КАТЕГОРИИ УЧАСТНИКОВ',
                    style: headTextStyle,
                  ),
                  const SizedBox(width: 30),
                  Container(
                    color: AppPallete.black10,
                    height: MediaQuery.of(context).size.width / 300,
                    width: MediaQuery.of(context).size.width / 5.5,
                  ),
                ],
              ),
              SizedBox(height: mediaQuery.size.width / 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ageButton(context, age_categoryes_min[0], () {
                    candidate.ageCategory = age_categoryes_min[0];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SectionsView(candidate: candidate)),
                    );
                  }, mediaQuery, false),
                  SizedBox(width: mediaQuery.size.width / 15),
                  ageButton(context, age_categoryes_min[1], () {
                    candidate.ageCategory = age_categoryes_min[1];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SectionsView(candidate: candidate)),
                    );
                  }, mediaQuery, false),
                  SizedBox(width: mediaQuery.size.width / 15),
                  ageButton(context, age_categoryes_min[2], () {
                    candidate.ageCategory = age_categoryes_min[2];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SectionsView(candidate: candidate)),
                    );
                  }, mediaQuery, false),
                ],
              ),
              SizedBox(height: mediaQuery.size.width / 15),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 20,
                    right: MediaQuery.of(context).size.width / 20),
                child: Divider(
                  thickness: MediaQuery.of(context).size.width / 300,
                  height: MediaQuery.of(context).size.width / 300,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
