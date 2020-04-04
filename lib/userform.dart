import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:workforcematch/skills.dart';

class UserForm extends StatefulWidget {
  @override
  UserFormState createState() {
    return UserFormState();
  }
}

class UserFormState extends State<UserForm> {
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
            ContactInformationWidget(),
            WorkInformationWidget(),
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text("Contact Information",
                style: TextStyle(fontWeight: FontWeight.bold))),
        EditTextContainer(
            labelText: "Name", warningText: "Please enter your name"),
        EditTextContainer(
            labelText: "Email", warningText: "Please enter your email"),
        EditTextContainer(
            labelText: "Phone Number",
            warningText: "Please enter your Phone Number"),
      ],
    );
  }
}

class WorkInformationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Text("Work Information",
              style: TextStyle(fontWeight: FontWeight.bold))),
      EditTextContainer(
          labelText: "Number of People",
          warningText: "Please enter number of People"),
      SkillsWidget(),
      EditTextContainer(
          labelText: "Start Date", warningText: "Please enter a Start Date"),
      EditTextContainer(
          labelText: "End Date", warningText: "Please enter an end Date"),
    ]);
  }
}

class EditTextContainer extends StatelessWidget {
  final labelText;
  final warningText;

  EditTextContainer({this.labelText, this.warningText});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 4.0),
        child: TextFormField(
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

class SkillsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SkillsWidgetState();
  }
}

class SkillsWidgetState extends State {
  final _autoCompleteKey = GlobalKey<AutoCompleteTextFieldState<Skill>>();

  void addSkillWidget(String skill) {
    setState(() => skillWidgets.add(SkillWidget(parent: this, skill: skill)));
  }

  void removeSkillWidget(SkillWidget skillWidget) {
    setState(() => skillWidgets.remove(skillWidget));
  }

  TextEditingController controller = TextEditingController();
  List<SkillWidget> skillWidgets = [];

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  void _loadData() async {
    await SkillViewModel.loadSkills();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            margin: const EdgeInsets.only(top: 4.0),
            child: AutoCompleteTextField<Skill>(
                key: _autoCompleteKey,
                suggestions: SkillViewModel.skills,
                decoration: InputDecoration(labelText: "Skills"),
                itemBuilder: (context, item) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        item.skill,
                        style: TextStyle(fontSize: 16.0),
                      )
                    ],
                  );
                },
                itemFilter: (item, query) {
                  return item.skill
                      .toLowerCase()
                      .startsWith(query.toLowerCase());
                },
                itemSorter: (a, b) {
                  return a.skill.compareTo(b.skill);
                },
                itemSubmitted: (item) => addSkillWidget(item.skill))),
        Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Row(children: skillWidgets)),
      ],
    );
  }
}

class SkillWidget extends StatelessWidget {
  final SkillsWidgetState parent;
  final String skill;

  SkillWidget({this.parent, this.skill});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey,
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        child: Row(
          children: <Widget>[
            Text(skill),
            IconButton(
              icon: Icon(Icons.close),
              iconSize: 20.0,
              onPressed: () {
                parent.removeSkillWidget(this);
              },
            ),
          ],
        ));
  }
}
