import 'package:flutter/material.dart';

import '../model/models.dart';
import '../widgets/header_widget.dart';

class PartnersPage extends StatelessWidget {
  const PartnersPage({Key? key}) : super(key: key);

  Widget itemCard(Partner data, BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width / 57),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.width / 8,
            width: MediaQuery.of(context).size.width / 7,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(data.photo!), fit: BoxFit.fill),
            ),
          ),
//          CircleAvatar(
//            child: Image.asset(data.photo!),
//          ),
          const SizedBox(
            height: 10,
          ),
          Text(data.name!),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Column(
          children: [
            SizedBox(height: mediaQuery.size.width / 40),
            const Center(child: HeaderWidget()),
            //SizedBox(height: mediaQuery.size.width / 15),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                  MediaQuery.of(context).size.shortestSide < 600 ? 2 : 4,
                ),
                itemBuilder: (context, i) => itemCard(partners[i], context),
                itemCount: partners.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
