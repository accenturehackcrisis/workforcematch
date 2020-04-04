import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';


class Demand {
  String name;
  String fieldOfWork;
  String location;
  String description;

  Demand({ this.name, this.fieldOfWork, this.location, this.description });

  factory Demand.fromJson(Map<String, dynamic> parsedJson) {
    return Demand(
        name: parsedJson['name'] as String,
        fieldOfWork: parsedJson['fieldOfWork'] as String,
        location: parsedJson['location'] as String,
        description: parsedJson['description'] as String
    );
  }
}

class DemandViewModel {
  

  static List<Demand> demands;

  static Future loadDemands() async {
    try {
      /*
      final databaseReference = FirebaseDatabase.instance.reference();
      
      databaseReference.once().then((DataSnapshot dataSnapshot) {
        demands = [
          Demand(data)
        ]
      });

       */

      demands = new List<Demand>();
      String jsonString = await rootBundle.loadString('assets/demands.json');
      Map parsedJson = json.decode(jsonString);
      var categoryJson = parsedJson['demands'] as List;
      for (int i = 0; i < categoryJson.length; i++) {
        demands.add(Demand.fromJson(categoryJson[i]));
      }
      
    } catch (e) {
      print(e);
    }
  }
}