import 'dart:convert';

import 'package:flutter/services.dart';

class Resource {
  String name;
  String fieldOfWork;
  String location;

  Resource({ this.name, this.fieldOfWork, this.location });

  factory Resource.fromJson(Map<String, dynamic> parsedJson) {
    return Resource(
        name: parsedJson['name'] as String,
        fieldOfWork: parsedJson['fieldOfWork'] as String,
        location: parsedJson['location'] as String
    );
  }
}

class ResourceViewModel {
  static List<Resource> resources;

  static Future loadResources() async {
    try {
      resources = new List<Resource>();
      String jsonString = await rootBundle.loadString('assets/resources.json');
      Map parsedJson = json.decode(jsonString);
      var categoryJson = parsedJson['resources'] as List;
      for (int i = 0; i < categoryJson.length; i++) {
        resources.add(Resource.fromJson(categoryJson[i]));
      }
    } catch (e) {
      print(e);
    }
  }
}