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

  Widget buildTitleText() {
    return Text(
      "Trying app",
      textScaleFactor: 3.0,
      textAlign: TextAlign.center,
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
              10.0,30.0
          ),
        ),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
      ),

    );
  }

  /** 3 tane wor içeren bir widget oluşturur **/
  Widget buildRowOfThree() {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // mainAxisAlignment: MainAxisAlignment.center,

      // Center hepsini toplar. spaceBetween ise ayırır ve yayar.
      children: <Widget>[
        buildRoundedBox("Row 1"),
        buildRoundedBox("Row 2"),
        buildRoundedBox("Row 3"),
      ],
    );
  }

  /** CaptionedRow olarak tanımlanan alt tanımlı row oluşturmak için kullanılır **/
  Column _buildCaptionedItem(String label, {String caption}) {
    return Column(
      children: <Widget>[
        buildRoundedBox(label),
        SizedBox(
          height: 5.0,
        ),
        Text(
          caption,
          textScaleFactor: 1.25,
        ),
      ],
    );
  }

  /** CaptionedRow olarak tanımlanan alt tanımlı row oluşturmak için kullanılır **/

  Widget buildCaptionedRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _buildCaptionedItem(
          "Row 1",
          caption: "Caption 1",
        ),
        _buildCaptionedItem(
          "Row 2",
          caption: "Caption 2",
        ),
        _buildCaptionedItem(
          "Row 3",
          caption: "Caption 3",
        ),
      ],
    );
  }

  Widget buildColumnWithinRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        buildRoundedBox("Row 1 "),
        SizedBox(width: 20.0),buildRoundedBox("Row 2"),
        SizedBox(width: 20.0),Column(
          children: <Widget>[
            buildRoundedBox(
              "Row 3 Column 1",
              height: 36.0,
            ),
            SizedBox(height: 16.0),
            buildRoundedBox(
              "Row 3 Column 2",
              height: 36.0,
            ),
          ],
        ),
      ],
    );
  }

  /* Expandent row oluşturan fonksiyon*/

  Widget _buildExpandedBox(
      String label,
      {
        double height = 88.0,
      }
  )
  {
    return Expanded(
      child: buildRoundedBox(
        label,
        height: height,
      ),
    );
  }

  Widget buildRowOfFive() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _buildExpandedBox("Row 1"),
        _buildExpandedBox("Row 2"),
        _buildExpandedBox("Row 3"),
        _buildExpandedBox("Row 4"),
        _buildExpandedBox("Row 5"),
      ],
    );
  }

  Widget buildColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        buildTitleText(),
        SizedBox(height: 20.0),

        // buildRowOfThree(), // Üçlü row oluşturur.

        // Rounded box oluşturur
        // buildRoundedBox(
        //  "Sale today",
        //  height: 150.0,
        //),

        //   buildCaptionedRow(), // caption içeren row oluşturur.

        // buildColumnWithinRow(), // 3 row ile son elementin 2 column bulunan row formudur.
        
        buildRowOfFive(),
      ],
    );
  }
}