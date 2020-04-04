import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'skills.dart';

class UserForm extends StatefulWidget {
  @override
  UserFormState createState() {
    return UserFormState();
  }
}

class UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  final _autoCompleteKey = GlobalKey<AutoCompleteTextFieldState<Skill>>();

  void removeSkillWidget(SkillWidget skillWidget) {
    setState(() => skillWidgets.remove(skillWidget));
  }

  TextEditingController controller = TextEditingController();

  List<SkillWidget> skillWidgets = [];

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text("Contact Information",
                    style: TextStyle(fontWeight: FontWeight.bold))),
            getTextContainer("Name", "Please enter your name"),
            getTextContainer("Email", "Please enter your address"),
            getTextContainer('Phone Number', 'Please enter your phone number'),
            Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Text("Company Information",
                    style: TextStyle(fontWeight: FontWeight.bold))),
            getTextContainer("Name", "Please enter the company name"),
            getTextContainer("Area of Work", "Please enter area of work"),
            getTextContainer("Location", "Please enter location"),
            Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Text("Work Information",
                    style: TextStyle(fontWeight: FontWeight.bold))),
            getTextContainer(
                "Number of People", "Please enter number of people"),
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
                    itemSubmitted: (item) {
                      setState(() => skillWidgets
                          .add(SkillWidget(parent: this, skill: item.skill)));
                    })),
            Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Row(children: skillWidgets)),
            getTextContainer("Start Date", "Please enter a Start Date"),
            getTextContainer("End Date", "Please enter an End Date"),
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

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  void _loadData() async {
    await SkillViewModel.loadSkills();
  }

  //TODO Make a widget instead of a class
  Container getTextContainer(String labelText, String warningText) {
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

class SkillWidget extends StatelessWidget {
  SkillWidget({this.parent, this.skill});

  final UserFormState parent;
  final String skill;

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
