import 'package:flutter/material.dart';
import 'main.dart';

extension MoreMovieTitlePage on MovieTitlePageState {

  goToDetailPage()
  {
    Navigator.push(context,MaterialPageRoute(builder: (context) => DetailPage(),),);
  }

  Widget buildTitlePageCore() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'M.Ö. 45 tarihinde Çiçero tarafından yazılan "de Finibus Bonorum et Malorum"un 1.10.32 sayılı bölümü',
          textScaleFactor: 1.5,
        ),
        SizedBox(height: 16.0),
        RaisedButton.icon(
          icon: Icon(Icons.arrow_forward),
          label: Text('Ayrıntılar'),
          onPressed: goToDetailPage,
        ),
      ],
    );
  }
}

extension MoreDetailPage on DetailPage {
  Widget buildDetailPageCore(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          overview,
        ),
      ],
    );
  }
}