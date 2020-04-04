import 'package:flutter/material.dart';
import 'userform.dart';
import 'list.dart';

void main() => runApp(MaterialApp(
    title: 'Happy to Help',
    theme: ThemeData(primarySwatch: Colors.green),
    home: ListApp()));

class ListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
                title: Text('Happy To Help'),
                bottom: TabBar(tabs: [
                  Tab(text: "Demand"),
                  Tab(text: "Resources")])),
            body: TabBarView( children: [CompanyList(), UserForm()]),
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
