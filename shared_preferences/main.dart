import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState(){
    super.initState();
    getSharedPreferences();

  }
  
  GlobalKey<ScaffoldState> _stateKey=new GlobalKey<ScaffoldState>();

  TextEditingController stringControl = new TextEditingController();
  TextEditingController doubleControl = new TextEditingController();
  TextEditingController intControl = new TextEditingController();
  bool checkbox=false;

  TextFieldContainer(TextEditingController controller, String title){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        controller:controller,
        style: TextStyle(
          color:Colors.black,
        ),
        decoration: new InputDecoration(
          focusColor: Colors.teal,
          focusedBorder: new OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            borderSide: BorderSide(color: Colors.teal)
          ),
          enabledBorder: new OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            borderSide: BorderSide(color: Colors.teal)
          ),
          filled: true,
          hintText: controller.text,
          fillColor: Colors.white,
          labelText: title,
          labelStyle: TextStyle(
            color: Colors.black
          )
        )
      )
    );

  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      key: _stateKey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Bool"),
                SizedBox(width: 10),
                Checkbox(
                  value:checkbox,
                  onChanged: (bool value){
                    setState(() {
                      checkbox=value;
                    });
                  }
                )
              ],
            ),
            TextFieldContainer(stringControl, "String"),
            TextFieldContainer(doubleControl, "Double"),
            TextFieldContainer(intControl, "Int"),
            FloatingActionButton(
              onPressed: () => setSharedPreferences(checkbox, stringControl.text, double.parse(doubleControl.text), int.parse(intControl.text)),
            ),
          ],
        )
      )
    );
  }

  setSharedPreferences(bool chk, String strn, double dbl, int integer) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("String", strn);
    await pref.setDouble("Double", dbl);
    await pref.setInt("Int", integer);
    await pref.setBool("Bool", chk);
    show("Saved");
  }
  getSharedPreferences() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState((){
      checkbox=pref.getBool("Bool") ?? false;
      stringControl.text = pref.getString("String") ?? "";
      doubleControl.text = (pref.getDouble("Double") ?? "0.0");
      intControl.text = (pref.getInt("Int") ?? 0).toString();
    });
  }

  void show(String value){
    _stateKey.currentState.showSnackBar(new SnackBar(content: new Text(value),));
  }

}