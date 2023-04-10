import 'dart:async';

import 'package:flutter/material.dart';

import '../../../app/theme/app_pallete.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({Key? key}) : super(key: key);

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final headTextStyle = TextStyle(fontSize: mediaQuery.size.width / 40);
    final countingDown =
        TextStyle(fontSize: mediaQuery.size.width / 20, color: AppPallete.blue);
    final timeTextStyle = TextStyle(
        fontSize: mediaQuery.size.width / 55, color: AppPallete.black4);
    return Column(
      children: [
        SizedBox(height: mediaQuery.size.width / 15),
        Text(
          'До окончания регистрации:',
          style: headTextStyle,
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${DateTime(2023, 5, 3).difference(DateTime.now()).inDays} : ',
                  style: countingDown,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'дней',
                  style: timeTextStyle,
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  '${23 - DateTime.now().hour} : ',
                  style: countingDown,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'часов      ',
                  style: timeTextStyle,
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  '${59 - DateTime.now().minute} : ',
                  style: countingDown,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'минут    ',
                  style: timeTextStyle,
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  (59 - DateTime.now().second).toString(),
                  style: countingDown,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'сек',
                  style: timeTextStyle,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: mediaQuery.size.width / 15),
      ],
    );
  }
}
