import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Sample App',
    home: Login(),
  ));
}


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController name = new TextEditingController();
  TextEditingController password = new TextEditingController();
  bool flag;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: name,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: password,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.blueAccent,
              onPressed: () {
                if(name.text == 'deneme' && password.text == '1234')
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
                }
                else{
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NotValidAuthPage()));
                }
              },
              child: Text(
                "Login",
                style: TextStyle(fontSize: 20.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NotValidAuthPage extends StatefulWidget {
  @override
  _NotValidAuthPageState createState() => _NotValidAuthPageState();
}

class _NotValidAuthPageState extends State<NotValidAuthPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Not Valid Auth'),
        ),
        body: Center(
          child: Text(
            "At least one of auth information is incorrect. Please check it.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red,
              fontSize: 50.0,
            ),
          ),
        )
    );
  }
}

class Question {
  int num;
  bool enable = false;
  bool flag = false;

  Question({this.num}) : super();
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Question> question =
  List.generate(5, (index) => new Question(num: index));

  @override
  Widget build(BuildContext context) {
    List<QButton> buttons =
    List.generate(5, (index) => new QButton(question: question[index]));

    return Scaffold(
        appBar: AppBar(
          title: Text('Question App'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: buttons,
            )));
  }
}

class QButton extends StatefulWidget {
  final Question question;
  QButton({Key key, this.question}) : super(key: key);

  @override
  _QButtonState createState() => _QButtonState();
}

class _QButtonState extends State<QButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => QAnswer(question: widget.question)));
          setState(() {});
        },
        child: Card(
          color: widget.question.enable
              ? (widget.question.flag ? Colors.red : Colors.green)
              : Colors.white,
          child: ListTile(
            title: Text('Question ${widget.question.num + 1}'),
            subtitle: Text('Yes or No'),
          ),
        ),
      ),
    );
  }
}

class QAnswer extends StatefulWidget {
  final Question question;

  QAnswer({Key key, this.question}) : super(key: key);

  @override
  _QAnswerState createState() => _QAnswerState();
}

class _QAnswerState extends State<QAnswer> {
  void enableWidget() {
    widget.question.enable = true;
  }

  void makeItTrue() {
    widget.question.flag = true;
  }

  void makeItFalse() {
    widget.question.flag = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => setState(() {
            Navigator.of(context).pop();
          }),
        ),
        title: Text("Answer: Question ${widget.question.num + 1}"),
      ),
      body: Center(
        child: Container(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  onPressed: () => setState(() {
                    enableWidget();
                    makeItFalse();
                  }),
                  child: Text('Yes'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  onPressed: () => setState(() {
                    enableWidget();
                    makeItTrue();
                  }),
                  child: Text('No'),
                ),
              ]),
        ),
      ),
    );
  }
}

