import 'package:flutter/material.dart';
import 'package:workforcematch/demands.dart';
import 'package:workforcematch/resources.dart';


class ResourceInfoPage extends StatelessWidget {
  final Resource company;

  ResourceInfoPage({this.company});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(company.companyName)),

        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView(children: <Widget>[
              InfoText(type: "Company Name", value: company.companyName),
              InfoText(type: "Completion Rate", value: company.completionRate),
              InfoText(
                  type: "Contact Person",
                  value: "${company.contactName} ${company.contactSurname}"
              ),
              InfoText(type: "Description", value: company.description),
              InfoText(type: "Email", value: company.email),
              InfoText(type: "Location", value: company.location.toString()),
              InfoText(type: "Number of People", value: company.numberOfPeople),
              InfoText(
                  type: "Phone Number", value: company.phoneNumber.toString()),
              InfoText(type: "Protective Equipment",
                  value: company.protectiveEquipment),
              InfoText(
                  type: "Time Interval",
                  value: "${company.startDate} - ${company.endDate}"
              ),
              InfoText(type: "Work Area", value: company.workArea)
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
        appBar: AppBar(title: Text(company.companyName)),

        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView(children: <Widget>[
              InfoText(type: "Company Name", value: company.companyName),
              InfoText(type: "Completion Rate", value: company.completionRate),
              InfoText(
                  type: "Contact Person",
                  value: "${company.contactName} ${company.contactSurname}"
              ),
              InfoText(type: "Description", value: company.description),
              InfoText(type: "Email", value: company.email),
              InfoText(type: "Location", value: company.location.toString()),
              InfoText(type: "Number of People", value: company.numberOfPeople),
              InfoText(
                  type: "Phone Number", value: company.phoneNumber.toString()),
              InfoText(type: "Protective Equipment",
                  value: company.protectiveEquipment),
              InfoText(
                  type: "Time Interval",
                  value: "${company.startDate} - ${company.endDate}"
              ),
              InfoText(type: "Training Required:", value: company.training),
              InfoText(type: "Work Hours", value: company.workHourSchedule)
            ])

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
        padding: const EdgeInsets.only(top: 16.0),
        child: Text("$type : $value",
            style: TextStyle(fontWeight: FontWeight.bold))
    );
  }

}