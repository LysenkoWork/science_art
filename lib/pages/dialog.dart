import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:science_art/pages/home/home_page.dart';

import '../model/candidate_model.dart';

Future<String?> dialog(
    BuildContext context, String title, String content, String button) async {
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
                }),
          ],
        );
      });
}

Future<String?> dialogForm(
    BuildContext context, String title, String content, String button) async {
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
                }),
          ],
        );
      });
}

Future<String?> dialogDelete(
    BuildContext context, String title, String content, int id) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(title),
          title: Text(content),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  child: const Text('Отмена'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                  child: const Text('Удалить'),
                  onPressed: () {
                    deleteCandidate(id);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        );
      });
}

Future<Candidate?> deleteCandidate(int id) async {
  String url = 'http://science-art.pro/delcan.php';
  final Response response = await post(Uri.parse(url), body: {
    'id': id,
  });
  return null;
}
