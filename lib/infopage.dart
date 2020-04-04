import 'package:flutter/material.dart';
import 'package:workforcematch/demands.dart';

import 'demands.dart';
import 'resources.dart';


class ResourceInfoPage extends StatelessWidget {
  final Resource company;


  ResourceInfoPage({this.company});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(company.name)),

        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ListView(children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text("Company Name: ${company.name}",
                      style: TextStyle(fontWeight: FontWeight.bold)))
            ])
        ));
  }
}

class DemandInfoPage extends StatelessWidget {
  final Demand company;


  DemandInfoPage({this.company});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(company.description)),

        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ListView(children: <Widget>[
        Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Text("Company Name: ${company.name}",
            style: TextStyle(fontWeight: FontWeight.bold)))
        ])
    ));
  }
}