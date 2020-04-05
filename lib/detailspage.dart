import 'package:flutter/material.dart';
import 'package:workforcematch/demands.dart';
import 'package:workforcematch/resources.dart';

class ResourceDetailsPage extends StatelessWidget {
  final Resource company;

  ResourceDetailsPage({this.company});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(company.companyName)),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView(children: <Widget>[
              ResourceBasicInfo(company: company),
              ContactInformation(company: company)
            ])));
  }
}

class ResourceBasicInfo extends StatelessWidget {
  final company;

  ResourceBasicInfo({this.company});


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "General Information",
              style: TextStyle(fontWeight: FontWeight.bold),
              textScaleFactor: 1.2,
            ),
            InfoText(type: "Company Name", value: company.companyName),
            InfoText(type: "Work Area", value: company.workArea),
            InfoText(type: "Description", value: company.description),
            InfoText(type: "Number of People", value: company.numberOfPeople),
            InfoText(type: "Skills", value: company.skills),
            InfoText(type: "Location", value: company.location.toString()),
            InfoText(
                type: "Time Interval",
                value: "${company.startDate} - ${company.endDate}"),
          ],
        ));
  }
}

class DemandDetailsPage extends StatelessWidget {
  final Demand company;

  DemandDetailsPage({this.company});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(company.companyName)),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView(children: <Widget>[
              DemandBasicInfo(company: company),
              RequirementInformation(company: company),
              ContactInformation(company: company)
            ])));
  }
}

class DemandBasicInfo extends StatelessWidget {
  final company;

  DemandBasicInfo({this.company});


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "General Information",
              style: TextStyle(fontWeight: FontWeight.bold),
              textScaleFactor: 1.2,
            ),
            InfoText(type: "Company Name", value: company.companyName),
            InfoText(type: "Description", value: company.description),
            InfoText(type: "Number of People", value: company.numberOfPeople),
            InfoText(type: "Status", value: company.status),
            InfoText(type: "Location (Zip Code)", value: company.location.toString()),
            InfoText(
                type: "Time Interval",
                value: "${company.startDate} - ${company.endDate}"),
          ],
        ));
  }
}

class RequirementInformation extends StatelessWidget {
  final company;

  RequirementInformation({this.company});


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Requirements",
              style: TextStyle(fontWeight: FontWeight.bold),
              textScaleFactor: 1.2,
            ),
            InfoText(type: "Skills Needed", value: company.skills),
            InfoText(type: "Work Hours", value: company.workHourSchedule),
            InfoText(
                type: "Protective Equipment Needed",
                value: company.protectiveEquipment),
            InfoText(
                type: "Additional Equipment",
                value: company.equipment
            ),
            InfoText(type: "Training Required:", value: company.training),
            InfoText(type: "Schedule", value: company.workHourSchedule)
          ],
        ));
  }
}


class ContactInformation extends StatelessWidget {
  final company;

  ContactInformation({this.company});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Contact Information",
              style: TextStyle(fontWeight: FontWeight.bold),
              textScaleFactor: 1.2
            ),
            InfoText(type: "Contact Person", value: company.contactName),
            InfoText(type: "Email", value: company.email),
            InfoText(
                type: "Phone Number", value: company.phoneNumber.toString()),
          ],
        ));
  }
}

class InfoText extends StatelessWidget {
  final type;
  final value;

  InfoText({this.type, this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Text("$type : $value"));
  }
}
