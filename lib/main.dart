import 'package:flutter/material.dart';
import 'package:workforcematch/list.dart';
import 'package:workforcematch/informationpage.dart';

void main() => runApp(MaterialApp(
    title: 'WorkforceMatch',
    theme: ThemeData(primarySwatch: Colors.purple),
    home: ListApp()));

class ListApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListAppState();
  }
}


class ListAppState extends State {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
                title: Text('WorkforceMatch'),
                bottom: TabBar(tabs: [
                  Tab(text: "Demand"),
                  Tab(text: "Resources"),
                  Tab(text : "Information")
                ])),
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [ DemandList(), ResourceList(), InformationPage()]),
            )
    );
  }
}




