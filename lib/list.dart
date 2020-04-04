import 'package:flutter/material.dart';
import 'companies.dart';

class CompanyList extends StatefulWidget {
  @override
  CompanyListState createState() {
    return CompanyListState();
  }
}

class CompanyListState extends State<CompanyList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // Let the ListView know how many items it needs to build.
      itemCount: CompanyViewModel.companies.length,
      // Provide a builder function. This is where the magic happens.
      // Convert each item into a widget based on the type of item it is.
      itemBuilder: (context, index) {
        final items = List<ListItem>.generate(
          CompanyViewModel.companies.length,
          (i) {
            final company = CompanyViewModel.companies[i];
            return CompanyItem(
                company.name,
                company.fieldOfWork,
                company.location);
          }

        );
        final item = items[index];

        return ListTile(
          title: item.buildTitle(context),
          subtitle: item.buildSubtitle(context),
        );
      },
    );
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  void _loadData() async {
    await CompanyViewModel.loadCompanies();
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
class CompanyItem implements ListItem {
  final String name;
  final String areaOfWork;
  final String location;

  CompanyItem(this.name, this.areaOfWork, this.location);

  Widget buildTitle(BuildContext context) => Text(name);

  Widget buildSubtitle(BuildContext context) => Text("$areaOfWork, $location");
}
