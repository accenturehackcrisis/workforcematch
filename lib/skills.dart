import 'dart:convert';
import 'package:flutter/services.dart';

class Skill {
  String skill;

  Skill({ this.skill });

  factory Skill.fromJson(Map<String, dynamic> parsedJson) {
    return Skill( skill: parsedJson['skill'] as String);
  }
}

class SkillViewModel {
  static List<Skill> skills;

  static Future loadSkills() async {
    try {
      skills = new List<Skill>();
      String jsonString = await rootBundle.loadString('assets/skills.json');
      Map parsedJson = json.decode(jsonString);
      var categoryJson = parsedJson['skills'] as List;
      for (int i = 0; i < categoryJson.length; i++) {
        skills.add(new Skill.fromJson(categoryJson[i]));
      }
    } catch (e) {
      print(e);
    }
  }
}