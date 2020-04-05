import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:workforcematch/demands.dart';

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
  final contactNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final emailController = TextEditingController();
  final endDateController = TextEditingController();
  final locationController = TextEditingController();
  final numberOfPeopleController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final protectiveEquipmentController = TextEditingController();
  final startDateController = TextEditingController();
  final trainingController = TextEditingController();
  final workHourScheduleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(
          children: <Widget>[
            DemandWorkInformationWidget(),
            RequirementInformationWidget(),
            ContactInformationWidget(
                contactNameController : contactNameController ,
                companyNameController : companyNameController,
                emailController : emailController,
                phoneNumberController : phoneNumberController
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 22.0),
              child: ButtonTheme(
                minWidth: double.infinity,
                child: RaisedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    if (_formKey.currentState.validate()) {
                      Demand demand = Demand(
                          contactName: contactNameController.text,
                          companyName: companyNameController.text,
                          email: emailController.text,
                          phoneNumber: phoneNumberController.text
                      );
                      pushToDatabase( demand);
                      // If the form is valid, display a Snackbar.
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Processing Data')));
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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(
          children: <Widget>[
            DemandWorkInformationWidget(),
            ContactInformationWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 22.0),
              child: ButtonTheme(
                minWidth: double.infinity,
                child: RaisedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, display a Snackbar.
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Processing Data')));
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
}

class ContactInformationWidget extends StatelessWidget {
  final contactNameController;
  final companyNameController;
  final emailController;
  final phoneNumberController;


  ContactInformationWidget({
    this.contactNameController,
    this.companyNameController,
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
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Text("General Information",
              style: TextStyle(fontWeight: FontWeight.bold))),
      EditTextContainer(
          labelText: "Company",
          warningText: "Please enter your company name"
      ),
      EditTextContainer(
          labelText: "Description",
          warningText: "Please enter a description"),
      EditTextContainer(
          labelText: "Number of People",
          warningText: "Please enter number of People"),
      EditTextContainer(
          labelText: "Location (Postal code)",
          warningText: "Please enter a postal code"),
      EditTextContainer(
          labelText: "Start Date", warningText: "Please enter a Start Date"),
      EditTextContainer(
          labelText: "End Date", warningText: "Please enter an end Date"),
    ]);
  }
}

class ResourceWorkInformationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Text("General Information",
              style: TextStyle(fontWeight: FontWeight.bold))),
      EditTextContainer(
          labelText: "Company",
          warningText: "Please enter your company name"
      ),
      EditTextContainer(
          labelText: "Work Area",
          warningText: "Please enter your work area"
      ),
      EditTextContainer(
          labelText: "Description",
          warningText: "Please enter a description"),
      EditTextContainer(
          labelText: "Number of People",
          warningText: "Please enter number of People"),
      EditTextContainer(
          labelText: "Skill",
          warningText: "Please enter your skills"
      ),
      EditTextContainer(
          labelText: "Location (Postal code)",
          warningText: "Please enter a postal code"),
      EditTextContainer(
          labelText: "Start Date", warningText: "Please enter a Start Date"),
      EditTextContainer(
          labelText: "End Date", warningText: "Please enter an end Date"),
    ]);
  }
}

class RequirementInformationWidget extends StatelessWidget {
  final skillText;
  RequirementInformationWidget({this.skillText});


  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Text("Requirements",
              style: TextStyle(fontWeight: FontWeight.bold))),
      EditTextContainer(
          labelText: "Skills Needed",
          warningText: "Please enter a number of skills"),
      EditTextContainer(
          labelText: "Work Hours", warningText: "What are the work hours?"),
      EditTextContainer(
          labelText: "Protective Equipment", warningText: "Do you need any Protective Equipment?"),
      EditTextContainer(
          labelText: "Additional Equipment", warningText: "Do you need any additional Equipment?"),
      EditTextContainer(
          labelText: "Training", warningText: "Does it require any Training?"),
      EditTextContainer(
          labelText: "Schedule", warningText: "What's the schedule?"),

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
