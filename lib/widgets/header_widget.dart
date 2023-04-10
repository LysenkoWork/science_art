import 'package:flutter/material.dart';
import '../../../app/theme/app_pallete.dart';
import '../pages/experts_page.dart';
import '../pages/home/home_page.dart';
import '../pages/organizers_page.dart';
import '../pages/partners_page.dart';
import '../pages/statute_page.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final headTextStyle = TextStyle(fontSize: mediaQuery.size.width / 40);
    return Wrap(
      alignment: WrapAlignment.center,
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
          child: Text(
            'КОНКУРС',
            style: headTextStyle,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          '/',
          style: headTextStyle,
        ),
        const SizedBox(width: 10),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const StatutePage()),
            );
          },
          child: Text(
            'ПОЛОЖЕНИЕ',
            style: headTextStyle,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          '/',
          style: headTextStyle,
        ),
        const SizedBox(width: 10),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OrganizersPage()),
            );
          },
          child: Text(
            'ОРГАНИЗАТОРЫ',
            style: headTextStyle,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          '/',
          style: headTextStyle,
        ),
        const SizedBox(width: 10),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ExpertsPage()),
            );
          },
          child: Text(
            'ЭКСПЕРТЫ',
            style: headTextStyle,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          '/',
          style: headTextStyle,
        ),
        const SizedBox(width: 10),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PartnersPage()),
            );
          },
          child: Text(
            'ПАРТНЁРЫ',
            style: headTextStyle,
          ),
        ),
      ],
    );
  }
}
