import 'package:flutter/material.dart';

class InformationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: ListView(
        children: <Widget>[
          Image(
            image: AssetImage("assets/workforcelogo.png"),
          ),
          InformationBox(
              title: "If you are in need of workforce",
              content: "Register your need and your contact details, "
                  "so the other companies representatives can reach out to you. "
                  "Location should specify where the work is located by postal code. "
                  "You should also specify if the work would require protective "
                  "equipment or any other type of equipment such as a car or a laptop. "
                  "If the work you need would require a training to begin with, "
                  "please specify the hours. The training content and coordination "
                  "is yours to coordinate when the workforce is available. "
                  "Please bear in mind that the work will be 100% voluntary and "
                  "should focus on helping the crisis at hand.  "
          ),
          InformationBox(
              title: "If you have volunteers to work",
              content:
                  "Register your need and your contact details, so the other companies´"
                  " representatives can reach out to you. Location should specify where the"
                  " workforce mostly located by postal code. Please specify your skills as"
                  " detailed as possible or by different registries so the demanding companies"
                  " can match their need easily. Please bear in mind that the work will be 100% voluntary. "
          ),
          InformationBox(
            title: "If you require support with the application or have questions",
            content: "Please reach out to us from the contact page by chat or by calling."
          )
        ],
      ),
    );
  }
}

class InformationBox extends StatelessWidget {
  final title;
  final content;

  InformationBox({this.title, this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
              textScaleFactor: 1.4,
            ),
            Padding(padding: EdgeInsets.only(top: 10), child: Text(content))
          ],
        ));
  }
}
