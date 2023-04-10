import 'package:flutter/material.dart';

import '../../../app/theme/app_pallete.dart';
import '../../../model/candidate_model.dart';
import '../../../model/models.dart';
import '../form_page.dart';
import '../widgets/AgeButtonWidget.dart';

class SectionsView extends StatelessWidget {
  SectionsView({Key? key, required this.candidate}) : super(key: key);
  Candidate candidate;

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
                    'Назад',
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
                    width: MediaQuery.of(context).size.width / 2.8,
                  ),
                  const SizedBox(width: 30),
                  Text(
                    'СЕКЦИИ',
                    style: headTextStyle,
                  ),
                  const SizedBox(width: 30),
                  Container(
                    color: AppPallete.black10,
                    height: MediaQuery.of(context).size.width / 300,
                    width: MediaQuery.of(context).size.width / 2.8,
                  ),
                ],
              ),
              SizedBox(height: mediaQuery.size.width / 15),
              candidate.ageCategory != age_categoryes_min[0]
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ageButton(context, sectionsView[0], () {
                          candidate.section = sectionsView[0];
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    FormPage(candidate: candidate)),
                          );
                        }, mediaQuery, true),
                        SizedBox(width: mediaQuery.size.width / 15),
                        ageButton(context, sectionsView[1], () {
                          candidate.section = sectionsView[1];
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    FormPage(candidate: candidate)),
                          );
                        }, mediaQuery, false),
                        SizedBox(width: mediaQuery.size.width / 15),
                        ageButton(context, sectionsView[2], () {
                          candidate.section = sectionsView[2];
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    FormPage(candidate: candidate)),
                          );
                        }, mediaQuery, false),
                      ],
                    )
                  : ageButton(context, 'ГРАФИКА / ЖИВОПИСЬ / АРТ-ОБЪЕКТ / ФОТОГРАФИЯ', () {
                      candidate.section = sectionsView[3];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FormPage(candidate: candidate)),
                      );
                    }, mediaQuery, false),
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
