import 'package:flutter/material.dart';
import 'package:workforcematch/userform.dart';
import 'package:workforcematch/list.dart';
import 'package:workforcematch/resources.dart';

void main() => runApp(MaterialApp(
    title: 'WorkforceMatch',
    theme: ThemeData(primarySwatch: Colors.green),
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
        length: 2,
        child: Scaffold(
            appBar: AppBar(
                title: Text('WorkforceMatch'),
                bottom: TabBar(tabs: [
                  Tab(text: "Demand"),
                  Tab(text: "Resources")])),
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [ DemandList(), ResourceList()]),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FormApp()));
              },
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ) // This trailing comma makes auto-formatting nicer for build methods
            ));
  }

}

class FormApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Happy to Help')), body: UserForm());
  }
}
