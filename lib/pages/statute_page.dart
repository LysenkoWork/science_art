import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '/pages/statude.dart';
import '/widgets/header_widget.dart';

class StatutePage extends StatelessWidget {
  const StatutePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final headTextStyle = TextStyle(fontSize: mediaQuery.size.width / 40);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: mediaQuery.size.width / 40),
            const HeaderWidget(),
            Padding(
              padding: EdgeInsets.all(mediaQuery.size.width / 15),
              child: const HtmlWidget(
                  html), //textStyle: TextStyle(fontSize: mediaQuery.size.width / 60),
            )
          ],
        ),
      ),
    );
  }
}
