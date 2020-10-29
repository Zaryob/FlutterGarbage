import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Suleyman Poyraz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Week 3'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(widget.title),
        ),
        backgroundColor: Colors.black,
      ),
      body: new Container(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: Colors.blue[300],
                      height: 100.0,
                      child: Center(
                        child: Icon(
                          Icons.favorite,
                          color: Colors.pink,
                          size: 36.0,
                          semanticLabel: 'Text to announce in accessibility modes',
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 100.0,
                      color: Colors.pink,
                      child: Center(
                        child: Text(
                          '2',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize:  24.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 100.0,
                      color: Colors.amber,
                      child: Center(
                        child: Text(
                          '3',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize:  24.0,

                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Expanded(
                  child: ListView(
                    children: <Widget>[
                      Card(
                        child: ListTile(
                          leading: Icon(
                            Icons.slow_motion_video_sharp,
                            color: Colors.pink,
                            size: 36.0,
                            semanticLabel: 'Text to announce in accessibility modes',
                          ),
                          title: Text(
                            'The Enchanted Nightingale',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:  16.0,
                            ),
                          ),
                          subtitle: const Text(
                              'Music by Julian Gable, Lyrics by Sidney Stain',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize:  12.0,
                              ),
                          ),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(
                            Icons.slow_motion_video_sharp,
                            color: Colors.pink,
                            size: 36.0,
                            semanticLabel: 'Text to announce in accessibility modes',
                          ),
                          title: Text(
                            'The Enchanted Nightingale',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:  16.0,
                            ),
                          ),
                          subtitle: const Text(
                            'Music by Julian Gable, Lyrics by Sidney Stain',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize:  12.0,
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(
                            Icons.slow_motion_video_sharp,
                            color: Colors.pink,
                            size: 36.0,
                            semanticLabel: 'Text to announce in accessibility modes',
                          ),
                          title: Text(
                            'The Enchanted Nightingale',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:  16.0,
                            ),
                          ),
                          subtitle: const Text(
                            'Music by Julian Gable, Lyrics by Sidney Stain',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize:  12.0,
                            ),
                          ),

                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(
                            Icons.slow_motion_video_sharp,
                            color: Colors.pink,
                            size: 36.0,
                            semanticLabel: 'Text to announce in accessibility modes',
                            ),
                          title: Text(
                            'The Enchanted Nightingale',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:  16.0,
                            ),
                          ),
                          subtitle: const Text(
                            'Music by Julian Gable, Lyrics by Sidney Stain',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize:  12.0,
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(
                            Icons.slow_motion_video_sharp,
                            color: Colors.pink,
                            size: 36.0,
                            semanticLabel: 'Text to announce in accessibility modes',
                          ),
                          title: Text(
                            'The Enchanted Nightingale',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:  16.0,
                            ),
                          ),
                          subtitle: const Text(
                            'Music by Julian Gable, Lyrics by Sidney Stain',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize:  12.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                    FlatButton(
                      textColor: Colors.black,
                      highlightColor: Colors.pink,
                      color: Colors.pinkAccent,
                      onPressed: () {
                        // Respond to button press
                      },
                      child: Text("Please Press"),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        // Respond to button press
                      },
                      tooltip: 'Increment',
                      backgroundColor: Colors.red,
                      child: Icon(Icons.add),
                    )
                  ]
                ),
            ],
          ),
      ),

    );
  }
}
