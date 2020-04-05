import 'package:firebase_database/firebase_database.dart';

const STATUS_OPEN = "Open";


class Demand {
  String companyName;
  String contactName;
  String description;
  String email;
  String endDate;
  int location;
  int numberOfPeople;
  String phoneNumber;
  String protectiveEquipment;
  String startDate;
  String status;
  String training;
  String workHourSchedule;
  String skills;
  String equipment;

  Demand({
    this.companyName,
    this.contactName,
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
    this.workHourSchedule,
    this.skills,
    this.equipment
  });


  factory Demand.fromJson(Map<dynamic,dynamic> parsedJson) {
    return Demand(
        companyName : parsedJson['CompanyName'],
        contactName : parsedJson['ContactName'],
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
        workHourSchedule : parsedJson['WorkHourSchedule'],
        skills: parsedJson['Skills'],
        equipment: parsedJson['Equipment']
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
        'ProtectiveEquipment' : protectiveEquipment,
        'StartDate' : startDate,
        'Status' : status,
        'Training' : training,
        'WorkHourSchedule' : workHourSchedule,
        'Skills' : skills,
        'Equipment' : equipment
      };
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

    demandsList.sort((a, b) {
      if(a.status != b.status){
        return a.status == STATUS_OPEN ? -1 : 1;
      } else{
        return a.companyName.compareTo(b.companyName);
      }
    });

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

  Future pushDemand (DatabaseReference databaseReference, Demand demand) async {
    databaseReference.child("Demands").push().set( demand.toJson());
  }
}
