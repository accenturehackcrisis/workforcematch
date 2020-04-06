import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:workforcematch/demands.dart';
import 'package:workforcematch/resources.dart';

class DemandFormApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('What do you need?')), body: DemandUserForm());
  }
}

class DemandUserForm extends StatefulWidget {
  @override
  DemandUserFormState createState() {
    return DemandUserFormState();
  }
}

class DemandUserFormState extends State<DemandUserForm> {
  static final databaseReference = FirebaseDatabase.instance.reference();

  final _formKey = GlobalKey<FormState>();

  final companyNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final numberOfPeopleController = TextEditingController();
  final locationController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();

  final skillsController = TextEditingController();
  final workHourScheduleController = TextEditingController();
  final protectiveEquipmentController = TextEditingController();
  final additionalEquipmentController = TextEditingController();
  final trainingController = TextEditingController();

  final contactNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(
          children: <Widget>[
            DemandWorkInformationWidget(
              companyNameController: companyNameController,
              descriptionController: descriptionController,
              numberOfPeopleController: numberOfPeopleController,
              locationController: locationController,
              startDateController: startDateController,
              endDateController: endDateController
            ),
            RequirementInformationWidget(
              skillsController: skillsController,
              workHourScheduleController: workHourScheduleController,
              protectiveEquipmentController: protectiveEquipmentController,
              additionalEquipmentController: additionalEquipmentController,
              trainingController: trainingController
            ),
            ContactInformationWidget(
                contactNameController : contactNameController ,
                emailController : emailController,
                phoneNumberController : phoneNumberController
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 22.0),
              child: ButtonTheme(
                minWidth: double.infinity,
                child: RaisedButton(
                  textColor: Colors.white,
                  onPressed: () {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    if (_formKey.currentState.validate()) {
                      Demand demand = Demand(
                          companyName: companyNameController.text,
                          contactName: contactNameController.text,
                          description: descriptionController.text,
                          email: emailController.text,
                          endDate: endDateController.text,
                          location: int.parse(locationController.text),
                          numberOfPeople: int.parse(numberOfPeopleController.text),
                          phoneNumber: phoneNumberController.text,
                          protectiveEquipment: protectiveEquipmentController.text,
                          startDate: startDateController.text,
                          status : STATUS_OPEN,
                          training: trainingController.text,
                          workHourSchedule: workHourScheduleController.text,
                          skills: skillsController.text,
                          equipment: additionalEquipmentController.text
                      );
                      pushToDatabase( demand);
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void pushToDatabase(Demand demand) async{
    await DemandViewModel().pushDemand(databaseReference, demand);
  }
}


class ResourceFormApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Thanks for your help')), body: ResourceUserForm());
  }
}

class ResourceUserForm extends StatefulWidget {
  @override
  ResourceUserFormState createState() {
    return ResourceUserFormState();
  }
}

class ResourceUserFormState extends State<ResourceUserForm> {
  static final databaseReference = FirebaseDatabase.instance.reference();

  final _formKey = GlobalKey<FormState>();

  final companyNameController = TextEditingController();
  final workAreaController = TextEditingController();
  final descriptionController = TextEditingController();
  final numberOfPeopleController = TextEditingController();
  final skillsController = TextEditingController();
  final locationController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();

  final contactNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(
          children: <Widget>[
            ResourceWorkInformationWidget(
              companyNameController: companyNameController,
              workAreaController: workAreaController,
              descriptionController: descriptionController,
              numberOfPeopleController: numberOfPeopleController,
              skillsController: skillsController,
              locationController: locationController,
              startDateController: startDateController,
              endDateController: endDateController
            ),
            ContactInformationWidget(
                contactNameController : contactNameController ,
                emailController : emailController,
                phoneNumberController : phoneNumberController
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 22.0),
              child: ButtonTheme(
                minWidth: double.infinity,
                child: RaisedButton(
                  textColor: Colors.white,
                  onPressed: () {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    if (_formKey.currentState.validate()) {
                      Resource resource = Resource(
                        companyName: companyNameController.text,
                        contactName: contactNameController.text,
                        description: descriptionController.text,
                        email: emailController.text,
                        endDate: endDateController.text,
                        location: int.parse(locationController.text),
                        numberOfPeople: int.parse(numberOfPeopleController.text),
                        phoneNumber: phoneNumberController.text,
                        startDate: startDateController.text,
                        workArea: workAreaController.text,
                        skills: skillsController.text
                      );
                      pushToDatabase(resource);
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void pushToDatabase(Resource resource) async{
    await ResourceViewModel().pushResource(databaseReference, resource);
  }

}

class ContactInformationWidget extends StatelessWidget {
  final contactNameController;
  final emailController;
  final phoneNumberController;


  ContactInformationWidget({
    this.contactNameController,
    this.emailController,
    this.phoneNumberController
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text("Contact Information",
                style: TextStyle(fontWeight: FontWeight.bold))),
        EditTextContainer(
            labelText: "Name",
            warningText: "Please enter your name",
            controller : contactNameController),
        EditTextContainer(
            labelText: "Email",
            warningText: "Please enter your email",
            controller : emailController),
        EditTextContainer(
            labelText: "Phone Number",
            warningText: "Please enter your Phone Number",
            controller: phoneNumberController)
      ],
    );
  }
}

class DemandWorkInformationWidget extends StatelessWidget {
  final companyNameController;
  final descriptionController;
  final numberOfPeopleController;
  final locationController;
  final startDateController;
  final endDateController;

  DemandWorkInformationWidget({
    this.companyNameController,
    this.descriptionController,
    this.numberOfPeopleController,
    this.locationController,
    this.startDateController,
    this.endDateController
  });


  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Text("General Information",
              style: TextStyle(fontWeight: FontWeight.bold))),
      EditTextContainer(
          labelText: "Company",
          warningText: "Please enter your company name",
          controller: companyNameController
      ),
      EditTextContainer(
          labelText: "Description",
          warningText: "Please enter a description",
          controller: descriptionController
      ),
      EditTextContainer(
          labelText: "Number of People",
          warningText: "Please enter number of People",
          controller: numberOfPeopleController
      ),
      EditTextContainer(
          labelText: "Location (Postal code)",
          warningText: "Please enter a postal code",
          controller: locationController
      ),
      EditTextContainer(
          labelText: "Start Date",
          warningText: "Please enter a Start Date",
          controller: startDateController
      ),
      EditTextContainer(
          labelText: "End Date",
          warningText: "Please enter an end Date",
          controller: endDateController
      )
    ]);
  }
}

class ResourceWorkInformationWidget extends StatelessWidget {
  final companyNameController;
  final workAreaController;
  final descriptionController ;
  final numberOfPeopleController;
  final skillsController;
  final locationController;
  final startDateController;
  final endDateController;

  ResourceWorkInformationWidget({
    this.companyNameController,
    this.workAreaController,
    this.descriptionController,
    this.numberOfPeopleController,
    this.skillsController,
    this.locationController,
    this.startDateController,
    this.endDateController
  });


  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Text("General Information",
              style: TextStyle(fontWeight: FontWeight.bold))),
      EditTextContainer(
          labelText: "Company",
          warningText: "Please enter your company name",
          controller: companyNameController,
      ),
      EditTextContainer(
          labelText: "Work Area",
          warningText: "Please enter your work area",
          controller: workAreaController,
      ),
      EditTextContainer(
          labelText: "Description",
          warningText: "Please enter a description",
          controller: descriptionController
      ),
      EditTextContainer(
          labelText: "Number of People",
          warningText: "Please enter number of People",
        controller: numberOfPeopleController),
      EditTextContainer(
          labelText: "Skill",
          warningText: "Please enter your skills",
          controller: skillsController,
      ),
      EditTextContainer(
          labelText: "Location (Postal code)",
          warningText: "Please enter a postal code",
          controller: locationController,
      ),
      EditTextContainer(
          labelText: "Start Date",
          warningText: "Please enter a Start Date",
          controller: startDateController,
      ),
      EditTextContainer(
          labelText: "End Date",
          warningText: "Please enter an end Date",
          controller: endDateController,
      ),
    ]);
  }
}

class RequirementInformationWidget extends StatelessWidget {
  final skillsController;
  final workHourScheduleController;
  final protectiveEquipmentController;
  final additionalEquipmentController;
  final trainingController;

  const RequirementInformationWidget({
    this.skillsController,
    this.workHourScheduleController,
    this.protectiveEquipmentController,
    this.additionalEquipmentController,
    this.trainingController
  });


  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Text("Requirements",
              style: TextStyle(fontWeight: FontWeight.bold))),
      EditTextContainer(
          labelText: "Skills Needed",
          warningText: "Please enter a number of skills",
          controller: skillsController
      ),
      EditTextContainer(
          labelText: "Work Hours",
          warningText: "What are the work hours?",
          controller: workHourScheduleController
      ),
      EditTextContainer(
          labelText: "Protective Equipment",
          warningText: "Do you need any Protective Equipment?",
          controller: protectiveEquipmentController

      ),
      EditTextContainer(
          labelText: "Additional Equipment",
          warningText: "Do you need any additional Equipment?",
          controller: additionalEquipmentController
      ),
      EditTextContainer(
          labelText: "Training",
          warningText: "Does it require any Training?",
          controller: trainingController
      ),
      ]);
  }
}

class EditTextContainer extends StatelessWidget {
  final labelText;
  final warningText;
  final controller;

  EditTextContainer({this.labelText, this.warningText, this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 4.0),
        child: TextFormField(
          controller: controller,
          validator: (value) {
            if (value.isEmpty) {
              return warningText;
            }
            return null;
          },
          decoration: InputDecoration(labelText: labelText),
        ));
  }
}
