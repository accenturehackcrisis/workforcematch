import 'package:firebase_database/firebase_database.dart';

class Resource {
  String companyName;
  String contactName;
  String description;
  String email;
  String endDate;
  int location;
  int numberOfPeople;
  String phoneNumber;
  String startDate;
  String workArea;
  String skills;

  Resource({
    this.companyName,
    this.contactName,
    this.description,
    this.email,
    this.endDate,
    this.location,
    this.numberOfPeople,
    this.phoneNumber,
    this.startDate,
    this.workArea,
    this.skills
  });


  factory Resource.fromJson(Map<dynamic, dynamic> parsedJson) {
    return Resource(
        companyName: parsedJson['CompanyName'],
        contactName: parsedJson['ContactName'],
        description: parsedJson['Description'],
        email: parsedJson['Email'],
        endDate: parsedJson['EndDate'],
        location: parsedJson['Location'],
        numberOfPeople: parsedJson['NumberofPeople'],
        phoneNumber: parsedJson['Phone'],
        startDate: parsedJson['StartDate'],
        workArea: parsedJson['WorkArea'],
        skills: parsedJson['Skills']
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'CompanyName': companyName,
        'ContactName' : contactName,
        'Description' : description,
        'Email' : email,
        'EndDate' : endDate,
        'Location' : location,
        'NumberofPeople' : numberOfPeople,
        'Phone' : phoneNumber,
        'StartDate' : startDate,
        'WorkArea' : workArea,
        'Skills' : skills,
      };
}

class Resources {
  List<Resource> resources;

  Resources({this.resources});

  factory Resources.fromJSON(Map<dynamic, dynamic> json) {
    return Resources(resources: parseResources(json));
  }

  static List<Resource> parseResources(resourcesJson) {
    List<Resource> resourceList = [];

    resourcesJson['Resources'].forEach((key, value) =>
        resourceList.add(Resource.fromJson(value))
    );

    resourceList.sort((a, b) {
      if(a.workArea == b.workArea){
        return a.companyName.compareTo(b.companyName);
      } else {
        return a.workArea.compareTo(b.workArea);
      }
    });

    return resourceList;
  }

}

class ResourceViewModel {
  List<Resource> resources = [];

  Future<List<Resource>> firebaseCalls(
      DatabaseReference databaseReference) async {
    Resources resourceList;
    DataSnapshot dataSnapshot = await databaseReference.once();
    Map<dynamic, dynamic> jsonResponse = dataSnapshot.value;
    resourceList = new Resources.fromJSON(jsonResponse);
    resources.addAll(resourceList.resources);
    return resources;
  }
  Future pushResource (DatabaseReference databaseReference, Resource resource) async {
    databaseReference.child("Resources").push().set( resource.toJson());
  }

}