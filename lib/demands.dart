import 'package:firebase_database/firebase_database.dart';

class Demand {
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
  String status;
  String training;
  String workHourSchedule;

  Demand({
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
    this.status,
    this.training,
    this.workHourSchedule
  });


  factory Demand.fromJson(Map<dynamic,dynamic> parsedJson) {
    return Demand(
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
        status : parsedJson['Status'],
        training : parsedJson['Training'],
        workHourSchedule : parsedJson['WorkHourSchedule']
    );
  }
}

class Demands {
  List<Demand> demands;

  Demands({this.demands});

  factory Demands.fromJSON(Map<dynamic, dynamic> json) {
    return Demands(demands: parseDemands(json));
  }

  static List<Demand> parseDemands(demandsJson) {
    List<Demand> demandsList = [];

    demandsJson['Demands'].forEach((key, value) =>
      demandsList.add(Demand.fromJson(value))
    );

    return demandsList;
  }

}

class DemandViewModel{
  List<Demand> demands=[];

  Future<List<Demand>> firebaseCalls (DatabaseReference databaseReference) async{
    Demands demandList;
    DataSnapshot dataSnapshot = await databaseReference.once();
    Map<dynamic,dynamic> jsonResponse=dataSnapshot.value;
    demandList = new Demands.fromJSON( jsonResponse);
    demands.addAll(demandList.demands);
    return demands;
  }
}
