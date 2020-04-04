import 'dart:convert';

import 'package:flutter/services.dart';

class Company {
  String name;
  String fieldOfWork;
  String location;

  Company({ this.name, this.fieldOfWork, this.location });

  factory Company.fromJson(Map<String, dynamic> parsedJson) {
    return Company(
        name: parsedJson['name'] as String,
        fieldOfWork: parsedJson['fieldOfWork'] as String,
        location: parsedJson['location'] as String
    );
  }
}

class CompanyViewModel {
  static List<Company> companies;

  static Future loadCompanies() async {
    try {
      companies = new List<Company>();
      String jsonString = await rootBundle.loadString('assets/companies.json');
      Map parsedJson = json.decode(jsonString);
      var categoryJson = parsedJson['companies'] as List;
      for (int i = 0; i < categoryJson.length; i++) {
        companies.add(new Company.fromJson(categoryJson[i]));
      }
    } catch (e) {
      print(e);
    }
  }
}