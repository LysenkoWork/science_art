import 'package:flutter/material.dart';
import 'package:science_art/pages/home/home_page.dart';

Future<String?> dialog(BuildContext context, String title, String content, String button) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(title),
          title: Text(content),
          actions: <Widget>[
            ElevatedButton(
                child: Text(button),
                onPressed: () {
                  Navigator.pop(context, button);
                }
            ),
          ],
        );
      });
}

Future<String?> dialogForm(BuildContext context, String title, String content, String button) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(title),
          title: Text(content),
          actions: <Widget>[
            ElevatedButton(
                child: Text(button),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                }
            ),
          ],
        );
      });
}