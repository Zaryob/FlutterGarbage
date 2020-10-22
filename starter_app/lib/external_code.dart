import 'package:flutter/material.dart';


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
        borderRadius: BorderRadius.all(
          Radius.circular(
              1.0
          ),
        ),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
      ),

    );
  }

  Widget buildColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        buildTitleText(),
        SizedBox(height: 20.0),
        buildRoundedBox(
          "Sale today",
          height: 150.0,
        ),
      ],
    );
  }
}