

import 'dart:async';
import 'dart:isolate';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const simplePeriodicTask = "simplePeriodicTask";
const simpleTaskKey = "simpleTask";

class DatabaseHelper {
  static final _databaseName = "games.db";
  static final _databaseVersion = 1;

  List<String> categoryName = ['pvp', 'shooter', 'mmofps', 'mmorpg'];

  static final columnId = 'id';
  static final columnName = 'name';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) {
    categoryName.forEach((category) async {
      await db.execute('''
          CREATE TABLE $category (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL
          )
          ''');
      print("Added $category table");
    });
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row, String table) async {
    Database db = await instance.database;
    //  print('inserted row: $row');
    return await db.insert(table, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<void> truncateTable(String table) async {
    Database db = await instance.database;
    await db.rawQuery("DELETE FROM $table");
    //await db.rawQuery("DELETE FROM $table");
    //print("Truncated table $table");
  }

  Future<List<GetGames>> games(String table) async {
    // Get a reference to the database.
    final Database db = await instance.database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query(table);

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return GetGames(
        id: maps[i][columnId],
        title: maps[i][columnName],
      );
    });
  }
}


void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) async {
    FlutterLocalNotificationsPlugin flip = new FlutterLocalNotificationsPlugin();

    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var IOS = new IOSInitializationSettings();

    // initialise settings for both Android and iOS device.
    var settings = new InitializationSettings(android: android, iOS: IOS);
    flip.initialize(settings);

    switch (task) {

      case simplePeriodicTask:
        _showNotificationWithDefaultSound(flip);
        print("$simplePeriodicTask was executed");
        await _JSONListView().loadData();
        break;

      case Workmanager.iOSBackgroundTask:
        print("The iOS background fetch was triggered");
        Directory tempDir = await getTemporaryDirectory();
        String tempPath = tempDir.path;
        print(
            "You can access other plugins in the background, for example Directory.getTemporaryDirectory(): $tempPath");
        break;
    }

    return Future.value(true);
  });

}

Future _showNotificationWithDefaultSound(flip) async {

  // Show a notification after every 15 minute with the first
  // appearance happening a minute after invoking the method
  var android = new AndroidNotificationDetails(
    'id',
    'channel ',
    'description',
    priority: Priority.high,
    importance: Importance.max,
    playSound: true,
  );
  var iOS = new IOSNotificationDetails();
  var platform = new NotificationDetails(
    android: android,
    iOS: iOS,
    macOS: null,
  );

  await flip.show(0,
      'FTP_Games',
      'Refreshed Database with given period 15 minutes.',
      platform,
      payload: 'Default_Sound'
  );
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();

  Workmanager.initialize(
      callbackDispatcher,
      isInDebugMode: false
      //isInDebugMode: true
  );

  Workmanager.registerPeriodicTask(
    "1",
    simplePeriodicTask,
    frequency: Duration(minutes: 15),
    //initialDelay: Duration(seconds: 15),
  );

  Workmanager.initialize(
    callbackDispatcher,
    isInDebugMode: false,
  );
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

enum GameCategoriesSettings { shooter, mmofps, pvp, mmorpg }

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GameCategoriesSettings gameCategoryThatShownInMainPage = null;
  String categoryName = '';

  @override
  void initState() {
    super.initState();
    _loadFireBaseCategory();
  }

  //Loading category values
  _loadFireBaseCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      switch (prefs.getInt('category') ?? 0) {
        case 0:
          gameCategoryThatShownInMainPage = GameCategoriesSettings.pvp;
          categoryName = 'pvp';
          break;
        case 1:
          gameCategoryThatShownInMainPage = GameCategoriesSettings.shooter;
          categoryName = 'shooter';
          break;
        case 2:
          gameCategoryThatShownInMainPage = GameCategoriesSettings.mmofps;
          categoryName = 'mmofps';
          break;
        case 3:
          gameCategoryThatShownInMainPage = GameCategoriesSettings.pvp;
          categoryName = 'pvp';
          break;
        case 4:
          gameCategoryThatShownInMainPage = GameCategoriesSettings.mmorpg;
          categoryName = 'mmorpg';
          break;
      }
    });
  }

  //Change category after dropdown select
  _changeCat(GameCategoriesSettings value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int category;
    setState(() {
      switch (value) {
        case GameCategoriesSettings.shooter:
          category = 1;
          categoryName = 'shooter';
          break;
        case GameCategoriesSettings.mmofps:
          category = 2;
          categoryName = 'mmofps';
          break;
        case GameCategoriesSettings.pvp:
          category = 3;
          categoryName = 'pvp';
          break;
        case GameCategoriesSettings.mmorpg:
          category = 4;
          categoryName = 'mmorpg';
          break;
      }
      prefs.setInt('category', category);
      prefs.commit();

      gameCategoryThatShownInMainPage = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    void handleClick(String value) async {
      switch (value) {
        case 'Settings':
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SecondRoute(cat: gameCategoryThatShownInMainPage)),
          );
          setState(() {
            // print(result);
            gameCategoryThatShownInMainPage = result;
            _changeCat(gameCategoryThatShownInMainPage);
          });
      }
    }

    return MaterialApp(
      title: 'Free To Play Games Database',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Free To Play Games Database'),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: handleClick,
              itemBuilder: (context) {
                return {'Settings'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: JSONListView(category: categoryName),
      ),
    );
  }
}

class GetGames {
  String title;
  int id;
  GetGames({
    this.title,
    this.id,
  });

  factory GetGames.fromJson(Map<String, dynamic> json) {
    return GetGames(
      title: json['title'],
      id: json['id'],
    );
  }
}

class JSONListView extends StatefulWidget {
  final String category;
  JSONListView({Key key, @required this.category}) : super(key: key);
  _JSONListView createState() => _JSONListView();
}

class _JSONListView extends State<JSONListView> {
  final dbHelper = DatabaseHelper.instance;

  final String mainAPIURL = 'https://www.freetogame.com/api/games/';
  String apiURL = '';

  List<String> categoryName = ['pvp', 'shooter', 'mmofps', 'mmorpg'];


  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(dataLoader, receivePort.sendPort);

    // The 'echo' isolate sends its SendPort as the first message
    SendPort sendPort = await receivePort.first;
    categoryName.forEach((category) async {
      if (category != '') {
        apiURL = mainAPIURL + "?category=" + category;
      } else {
        apiURL = mainAPIURL;
      }

      List msg = await sendReceive(
        sendPort,
        apiURL,
      );

      setState(() {
        _insert(msg, category);
      });
    });
  }

  // the entry point for the isolate
  static Future<void> dataLoader(SendPort sendPort) async {
    // Open the ReceivePort for incoming messages.
    ReceivePort port = ReceivePort();

    // Notify any other isolates what port this isolate listens to.
    sendPort.send(port.sendPort);

    await for (var msg in port) {
      String data = msg[0];
      SendPort replyTo = msg[1];

      String dataURL = data;
      http.Response response = await http.get(dataURL);
      // Lots of JSON to parse
      replyTo.send(jsonDecode(response.body));
    }
  }

  Future sendReceive(SendPort port, msg) {
    ReceivePort response = ReceivePort();
    port.send([msg, response.sendPort]);
    return response.first;
  }

  void _insert(List games, String table) async {
    // row to insert
    await dbHelper.truncateTable(table);

    games.forEach((game) async {
      Map<String, dynamic> row = {
        DatabaseHelper.columnName: game["title"],
        DatabaseHelper.columnId: game["id"],
      };
      final id = await dbHelper.insert(row, table);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GetGames>>(
        future: dbHelper.games(widget.category),
        builder: (context, snapshot) {
          //pushToFirebase();
          if (snapshot.hasError) {
            return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.warning_rounded,
                        color: Colors.red,
                        size: 70,
                      ),
                      Text("Opps... Something went wrong"),
                    ]));
          } else if (!snapshot.hasData) {
            return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(
                        semanticsLabel: "Awaiting results...",
                      ),
                      Text("Awaiting results..."),
                    ]));
          } else {
            // pushToFirebase(snapshot.data);
            // _insert(snapshot.data);
            var len = 0;
            if (snapshot.data.length > 10) {
              len = 10;
            } else {
              len = snapshot.data.length;
            }
            return ListView.separated(
              itemCount: len,
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(snapshot.data[index].title),
                );
              },
            );
          }
        });
  }

  // List<GetGames> data
  Future<void> pushToFirebase(List<GetGames> data) async {
    CollectionReference games = FirebaseFirestore.instance.collection("games");

    final gamesDocs = await games.get();

    Future<void> addGame(GetGames game) {
      return games
          .add({'name': game.title})
          .then((value) => print("Added game ${game.title}"))
          .catchError((error) => print("Failed to add game: $error"));
    }

    if (gamesDocs.docs.length == 0) {
      //If there isn't any collection under games
      for (GetGames game in data) {
        addGame(game);
      }
    } else {
      print("Database already generated skipping...");
    }
  }

}

class SecondRoute extends StatefulWidget {
  final GameCategoriesSettings cat;
  SecondRoute({Key key, @required this.cat}) : super(key: key);

  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  GameCategoriesSettings _site = null;

  @override
  Widget build(BuildContext context) {
    if (_site == null) {
      _site = widget.cat;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: const Text('Shooter'),
            leading: Radio(
              value: GameCategoriesSettings.shooter,
              groupValue: _site,
              onChanged: (GameCategoriesSettings value) {
                setState(() {
                  _site = value;
                });
              },
            ),
          ),
          ListTile(
            title:
            const Text('Massively Multiplayer Online First-Person Shooter'),
            leading: Radio(
              value: GameCategoriesSettings.mmofps,
              groupValue: _site,
              onChanged: (GameCategoriesSettings value) {
                setState(() {
                  _site = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Player versus Player'),
            leading: Radio(
              value: GameCategoriesSettings.pvp,
              groupValue: _site,
              onChanged: (GameCategoriesSettings value) {
                setState(() {
                  _site = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Massively Multiplayer Online Role-Playing Game'),
            leading: Radio(
              value: GameCategoriesSettings.mmorpg,
              groupValue: _site,
              onChanged: (GameCategoriesSettings value) {
                setState(() {
                  _site = value;
                });
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // get the text in the TextField and send it back to the FirstScreen
              if (_site == null) {
                _site = widget.cat;
              }
              Navigator.pop(context, _site);
            },
            child: Text('Ok'),
          )
        ],
      ),
    );
  }
}
