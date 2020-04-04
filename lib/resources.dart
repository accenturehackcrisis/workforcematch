import 'dart:convert';
import 'package:flutter/services.dart';

import 'package:firebase_database/firebase_database.dart';

class Resource {
  String companyName;
  String completionRate;
  String contactName;
  String contactSurname;
  String description;
  String email;
  String endDate;
  int location;
  int numberOfPeople;
  int phoneNumber;
  String protectiveEquipment;
  String startDate;
  String workArea;

  Resource({
    this.companyName,
    this.completionRate,
    this.contactName,
    this.contactSurname,
    this.description,
    this.email,
    this.endDate,
    this.location,
    this.numberOfPeople,
    this.phoneNumber,
    this.protectiveEquipment,
    this.startDate,
    this.workArea
  });


  factory Resource.fromJson(Map<dynamic,dynamic> parsedJson) {
    return Resource(
        companyName : parsedJson['CompanyName'],
        completionRate : parsedJson['CompletionRate'],
        contactName : parsedJson['ContactName'],
        contactSurname : parsedJson['ContactSurname'],
        description : parsedJson['Description'],
        email : parsedJson['Email'],
        endDate : parsedJson['EndDate'],
        location : parsedJson['Location'],
        numberOfPeople : parsedJson['NumberofPeople'],
        phoneNumber : parsedJson['Phone'],
        protectiveEquipment : parsedJson['ProtectiveEquipment'],
        startDate : parsedJson['StartDate'],
        workArea: parsedJson['WorkArea']
    );
  }
}

class Resources {
  List<Resource> resources;

  Resources({this.resources});

  factory Resources.fromJSON(Map<dynamic, dynamic> json) {
    return Resources(resources : parseResources(json));
  }

  static List<Resource> parseResources(resourcesJson) {
    List<Resource> resourceList = [];

    resourcesJson['Resources'].forEach((key, value) =>
        resourceList.add(Resource.fromJson(value))
    );

    return resourceList;
  }

}

class ResourceViewModel{
  List<Resource> resources=[];

  Future<List<Resource>> firebaseCalls (DatabaseReference databaseReference) async{
    Resources resourceList;
    DataSnapshot dataSnapshot = await databaseReference.once();
    Map<dynamic,dynamic> jsonResponse=dataSnapshot.value;
    resourceList = new Resources.fromJSON( jsonResponse);
    resources.addAll(resourceList.resources);
    return resources;
  }
}