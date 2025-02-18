import 'package:flutter/material.dart';

class Activity extends StatelessWidget {
  const Activity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Nos activités"),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(15),
            child: Column(
              spacing: 12,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Campagne don de sang 1997",
                  textAlign: TextAlign.right,
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset("images/blood1.jpg")),
                    Divider(),
                  Text(
                  "Campagne don de sang 2025 FARDC",
                  textAlign: TextAlign.right,
                  style: TextStyle(fontWeight: FontWeight.w300),),

                ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset("images/blood3.jpg")),
              ],
            ),
          ),
        ));
  }
}
