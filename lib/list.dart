import 'package:flutter/material.dart';
import 'package:workforcematch/infopage.dart';
import 'resources.dart';
import 'demands.dart';

class ResourceList extends StatefulWidget {
  @override
  ResourceListState createState() {
    return ResourceListState();
  }
}

class DemandList extends StatefulWidget {
  @override
  DemandListState createState() {
    return DemandListState();
  }
}

class ResourceListState extends State<ResourceList>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // Let the ListView know how many items it needs to build.
      itemCount: ResourceViewModel.resources.length,
      // Provide a builder function. This is where the magic happens.
      // Convert each item into a widget based on the type of item it is.
      itemBuilder: (context, index) {
        final company = ResourceViewModel.resources[index];
        final item =
            ResourceItem(company.name, company.fieldOfWork, company.location);

        return ListTile(
            title: item.buildTitle(context),
            subtitle: item.buildSubtitle(context),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ResourceInfoPage(company: company)));
            });
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class DemandListState extends State<DemandList>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // Let the ListView know how many items it needs to build.
      itemCount: DemandViewModel.demands.length,
      // Provide a builder function. This is where the magic happens.
      // Convert each item into a widget based on the type of item it is.
      itemBuilder: (context, index) {
        final company = DemandViewModel.demands[index];
        final item = DemandItem(company.name, company.description,
            company.fieldOfWork, company.location);

        return ListTile(
          title: item.buildTitle(context),
          subtitle: item.buildSubtitle(context),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DemandInfoPage(company: company)));
          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
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

  ResourceItem(this.name, this.areaOfWork, this.location);

  Widget buildTitle(BuildContext context) => Text(name);

  Widget buildSubtitle(BuildContext context) => Text("$areaOfWork, $location");
}

class DemandItem implements ListItem {
  final String name;
  final String description;
  final String areaOfWork;
  final String location;

  DemandItem(this.name, this.description, this.areaOfWork, this.location);

  Widget buildTitle(BuildContext context) => Text(description);

  Widget buildSubtitle(BuildContext context) => Text("$name, $areaOfWork");
}
