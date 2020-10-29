import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Input Stuff',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Input Stuff Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// For age switch
const _youAre = 'You are';
const _compatible = 'compatible.';

// For submit button
const _submitted = 'submitted.';

// for ratio button
enum Gender { Female, Male, Other }
String shorten(Gender gender) => gender.toString().replaceAll("Gender.", "");

// for dropdown menu

enum Relationship {
  Friend,
  OneDate,
  Ongoing,
  Committed,
  Marriage,
}

Map<Relationship, String> show = {
  Relationship.Friend: "Friend",
  Relationship.OneDate: "One date",
  Relationship.Ongoing: "Ongoing relationship",
  Relationship.Committed: "Committed relationship",
  Relationship.Marriage: "Marriage",
};

List<DropdownMenuItem<Relationship>> _relationshipsList = [
  DropdownMenuItem(
    value: Relationship.Friend,
    child: Text(show[Relationship.Friend]),
  ),
  DropdownMenuItem(
    value: Relationship.OneDate,
    child: Text(show[Relationship.OneDate]),
  ),
  DropdownMenuItem(
    value: Relationship.Ongoing,
    child: Text(show[Relationship.Ongoing]),
  ),
  DropdownMenuItem(
    value: Relationship.Committed,
    child: Text(show[Relationship.Committed]),
  ),
  DropdownMenuItem(
    value: Relationship.Marriage,
    child: Text(show[Relationship.Marriage]),
  ),
];



class _MyHomePageState extends State<MyHomePage> {

  // for age switch
  bool _ageSwitchValue = false;
  String _ageMessageToUser = "$_youAre NOT $_compatible";

  // for submit button
  String _sbtnMessageToUser = "$_youAre not $_submitted";

  // for slider
  double _sliderValue = 1.0;

  // for texteditingcontroller
  TextEditingController _nameController;
  String yourName="";

  // For ratio button
  Gender _genderRadioValue;
  String _genderString="";

  // For dropdown menu
  Relationship _relationshipDropdownValue;

  // You need to use initState and dispose when using TextEditingController
  @override
  void initState()
  {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose(){
    _nameController.dispose();
    super.dispose();
  }

  // Result Area is a changable Text area wrapper.
  Widget _buildResultArea(String message) {
    return Text(
        message
    );
  }

  /** Build function for widget***/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            _buildAgeSwitch(),
            _buildSubmitButton(),
            _buildSlider(),
            _buildTextField(),
            _buildGenderRadio(),
            _buildGenderArea(),
            _buildDropdownButtonRow(),
            _buildResultsIcon(),
          ],
        ),
      ),
    );
  }

  /*** Start of Age Switch ***/
  Widget _buildAgeSwitch() {
    return Row(
      children: <Widget>[
        Text("Are you 18 or older?"),
        Switch(value:
        _ageSwitchValue,
          onChanged: _updateAgeSwitch,
        ),
        _buildResultArea(_ageMessageToUser),
      ],
    );
  }
  void _updateAgeSwitch(bool newValue) {
    setState( () {
      _ageSwitchValue = newValue;
      _ageMessageToUser =_youAre + (_ageSwitchValue ? " " : " NOT ") + _compatible;
    }
    );
  }

  /*** Start of Submit Button ***/

  Widget _buildSubmitButton() {
    return Row(
        children: <Widget>[
          RaisedButton(
            onPressed: _updateSubmitArea,
            child: Text("Submit"),

          ),
          _buildResultArea(_sbtnMessageToUser),

        ]
    );
  }

  void _updateSubmitArea() {
    setState( () {
      _sbtnMessageToUser =_youAre + (_ageSwitchValue ? " " : " not ") + _submitted;
    }
    );
  }

  /*** Start of Slider ***/
  Widget _buildSlider() {
    return Row(
        children: <Widget>[
          Slider(
            min: 1.0,
            max: 10.0,
            divisions: 9,
            value: _sliderValue,
            onChanged: _updateSlider,
            label: '${_sliderValue.toInt()}',
          ),
          _buildResultArea('Your slider level is ${_sliderValue.toInt()}'),

        ]
    );
  }

  void _updateSlider(double newValue) {
    setState(() {
      _sliderValue = newValue;
    }
    );
  }

  /*** Start of TextField ***/
  Widget _buildTextField() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: TextField(
          controller: _nameController,
          decoration: _buildDecoration("Your Name:"),
          onSubmitted: (String value) async {
            await showDialog<void>(
              context: context,
              builder: (BuildContext context) {

                return AlertDialog(
                  title: Text(value.isEmpty ? 'Please enter a name!': 'Thanks'),
                  content: Text(
                      (value.isEmpty ? '':'Your name is "$value"')
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          },

        )
    );
  }

  InputDecoration _buildDecoration(String text){
    return InputDecoration(
      labelText: text,
      hintText: "Please write your name.",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    );
  }


  Widget _buildGenderRadio() {
    return Row(
      children: <Widget>[
        Text(shorten(Gender.Female)),
        Radio(
          value: Gender.Female,
          groupValue: _genderRadioValue,
          onChanged: _updateGenderRadio,
        ),
        SizedBox(width: 25.0),
        Text(
            shorten(Gender.Male)
        ),
        Radio(
          value: Gender.Male,
          groupValue: _genderRadioValue,
          onChanged: _updateGenderRadio,
        ),
        SizedBox(
            width: 25.0
        ),
        Text(
            shorten(Gender.Other)
        ),
        Radio(
          value: Gender.Other,
          groupValue: _genderRadioValue,
          onChanged: _updateGenderRadio,
        ),
      ],
    );
  }

  Widget _buildGenderArea() {
    return Row(children: <Widget>[
      RaisedButton(
        child: Text("Submit"),
        onPressed: _genderRadioValue != null ? _updateResults : null,
      ),
      SizedBox(
        width: 15.0,
      ),
      Text(
        _genderString,
        textAlign: TextAlign.center,
      ),
    ],
    );
  }  /// Actions

  void _updateGenderRadio(Gender newValue) {
    setState(() {
      _genderRadioValue = newValue;
    }
    );
  }

  void _updateResults() {
    setState(() {
      _genderString = "You selected ${shorten(_genderRadioValue)}.";
    });
  }

  /*** For dropdown menu***/
  Widget _buildDropdownButtonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        DropdownButton<Relationship>(
          items: _relationshipsList,
          onChanged: _updateRelationshipDropdown,
          value: _relationshipDropdownValue,
          hint: Text("Select One"),
        ),
        if (_relationshipDropdownValue != null)
          FlatButton(
            child: Text(
              "Reset",
              style: TextStyle(color: Colors.blue),
            ),
            onPressed: _resetDrop,
          ),
      ],
    );
  }

  Widget _buildResultsIcon() {
    if (_relationshipDropdownValue != null) {
      return (_relationshipDropdownValue.index >= 3)  ?
      Icon(
          Icons.favorite,
          size: 36.0,
      ) :
      Icon(
          Icons.warning_amber_rounded,
          size: 36.0,
      );
    } else {
      return SizedBox();
    }
  }

  void _resetDrop() {
    setState(() {
      _relationshipDropdownValue = null;
    }
    );
  }

  void _updateRelationshipDropdown(Relationship newValue) {
    setState(() {
      _relationshipDropdownValue = newValue;
    }
    );
  }
}
