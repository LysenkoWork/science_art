import 'package:flutter/material.dart';
import '../../../app/theme/app_pallete.dart';

Widget ageButton(
    BuildContext context, String text, GestureTapCallback onTup, mediaQuery, bool multiText) {
  final timeTextStyle =
      TextStyle(fontSize: mediaQuery.size.width / 55, color: AppPallete.black8);
  return Column(
    children: [
      multiText == false
          ? Text(
              text,
              style: timeTextStyle,
            )
          : Column(
              children: [
                Text(
                  'ХОЛСТ / ВИДЕО-АНИМАЦИЯ',
                  style: timeTextStyle,
                ),
                Text(
                'ФОТОГРАФИКА / ИЛЛЮСТРАЦИЯ',
                  style: timeTextStyle,
                ),
                Text(
                  'АРТ-ОБЪЕКТ / ПАННО',
                  style: timeTextStyle,
                ),
                Text(
                  'РИСОВАНИЕ В VR',
                  style: timeTextStyle,
                ),
              ],
            ),
      SizedBox(height: mediaQuery.size.width / 35),
      InkWell(
        onTap: onTup,
        child: Container(
          height: mediaQuery.size.width / 15,
          width: mediaQuery.size.width / 4,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
            color: AppPallete.blue,
          ),
          child: Center(
              child: Text(
            'Подать заявку',
            style: TextStyle(
                fontSize: mediaQuery.size.width / 45, color: Colors.white),
          )),
        ),
      ),
    ],
  );
}
