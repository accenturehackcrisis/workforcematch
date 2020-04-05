import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:workforcematch/detailspage.dart';
import 'package:workforcematch/resources.dart';
import 'package:workforcematch/demands.dart';
import 'package:workforcematch/userform.dart';

class DemandList extends StatelessWidget {
  static final databaseReference = FirebaseDatabase.instance.reference();

  final futureBuilder = new FutureBuilder(
      future: DemandViewModel().firebaseCalls(databaseReference),
      builder: (BuildContext context, AsyncSnapshot snapshot) =>
          getBuilder(snapshot));

  static Widget getBuilder(AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        return new Text('Press button to start');
      case ConnectionState.waiting:
        return new Text('Loading....');
      default:
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        } else {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              final demand = snapshot.data[index];
              final item = DemandItem(
                  description: demand.description,
                  name: demand.companyName,
                  location: demand.location.toString(),
                  status: demand.status,
                  numberOfPeople: demand.numberOfPeople);
              return ListTile(
                  title: item.buildTitle(context),
                  subtitle: item.buildSubtitle(context),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DemandDetailsPage(company: demand)));
                  });
            },
          );
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: futureBuilder,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DemandFormApp()));
          },
          child: Icon(Icons.add),
        ));
  }
}

class ResourceList extends StatelessWidget {
  static final databaseReference = FirebaseDatabase.instance.reference();

  final futureBuilder = new FutureBuilder(
      future: ResourceViewModel().firebaseCalls(databaseReference),
      builder: (BuildContext context, AsyncSnapshot snapshot) =>
          getBuilder(snapshot));

  static Widget getBuilder(AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        return new Text('Press button to start');
      case ConnectionState.waiting:
        return new Text('Loading....');
      default:
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        } else {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              final resource = snapshot.data[index];
              final item = ResourceItem(resource.companyName, resource.workArea,
                  resource.location.toString(), resource.numberOfPeople);
              return ListTile(
                  title: item.buildTitle(context),
                  subtitle: item.buildSubtitle(context),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ResourceDetailsPage(company: resource)));
                  });
            },
          );
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: futureBuilder,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ResourceFormApp()));
          },
          child: Icon(Icons.add),
        ));
  }
}

/// The base class for the different types of items the list can contain.
abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);
}

/// A ListItem that contains data to display a message.
class ResourceItem implements ListItem {
  final String name;
  final String areaOfWork;
  final String location;
  final int numberOfPeople;

  ResourceItem(this.name, this.areaOfWork, this.location, this.numberOfPeople);

  Widget buildTitle(BuildContext context) => Text(name);

  Widget buildSubtitle(BuildContext context) =>
      Text("$areaOfWork, $location, $numberOfPeople people");
}

class DemandItem implements ListItem {
  final String description;
  final String name;
  final String location;
  final String status;
  final int numberOfPeople;

  DemandItem(
      {this.description,
      this.name,
      this.location,
      this.status,
      this.numberOfPeople});

  Widget buildTitle(BuildContext context) => Text(description);

  Widget buildSubtitle(BuildContext context) =>
      Text("$name, $location, $numberOfPeople people, $status");
}
