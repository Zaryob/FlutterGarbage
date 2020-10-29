import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey[400],
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: buildColumn(context),
      ),
    );
  }

  Widget buildRoundedBox(String label, { double height = 88 }) {
    return Container(
      height: height,
      width: 88.0,
      alignment: Alignment(0.0, 0.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: Colors.black
        ),
        // Border Radius dediğimiz şey ucu yumuşatılmış çerçevedir.
        borderRadius: BorderRadius.all(
          // elliptical'da x ve y noktalarına göre elips belirlenir
          // circle için ise pi/2 radyanı kullanılır
          Radius.elliptical(
              10.0, 30.0
          ),
        ),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
      ),

    );
  }

  Widget buildColumn(context) {
    if (MediaQuery
        .of(context)
        .orientation == Orientation.landscape) {
      return _buildOneLargeRow();
    } else {
      return _buildTwoSmallRows();
    }
  }

  Widget _buildOneLargeRow() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            buildRoundedBox("Aardvark"),
            buildRoundedBox("Baboon"),
            buildRoundedBox("Unicorn"),
            buildRoundedBox("Eel"),
            buildRoundedBox("Emu"),
            buildRoundedBox("Platypus"),
          ],
        ),
      ],
    );
  }

  Widget _buildTwoSmallRows() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildRoundedBox("Row 1"),
            buildRoundedBox("Row 2"),
            buildRoundedBox("Row 3"),
          ],
        ),

        SizedBox(
          height: 30.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildRoundedBox("Row 4"),
            buildRoundedBox("Row 5"),
            buildRoundedBox("Row 6"),
          ],
        ),
      ],
    );
  }
}