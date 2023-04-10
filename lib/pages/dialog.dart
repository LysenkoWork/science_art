import 'package:flutter/material.dart';

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