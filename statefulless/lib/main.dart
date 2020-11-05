import 'package:flutter/material.dart';


class NewsBoxFavourite extends StatefulWidget {

  final int _num;
  final bool _like;

  NewsBoxFavourite(this._num, this._like);

  @override
  createState() => new NewsBoxFavouriteState(_num, _like);

}


class NewsBoxFavouriteState extends State<NewsBoxFavourite> {

  int num;
  bool like;

  NewsBoxFavouriteState(this.num, this.like);

  void pressButton() {
    setState(() {
      like = !like;
      if(like) num++;
      else num--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
        children: [
          new Text(
              'Favourite $num',
              textAlign: TextAlign.center
          ),
          new IconButton(
              icon: new Icon(
                  like ? Icons.star : Icons.star_border,
                  size: 30.0,
                  color: Colors.blue[500]
              ),
              onPressed: pressButton
          )
        ]
    );
  }
}


class NewsBox extends StatelessWidget {
  final String _title;
  final String _text;
  int _num;
  bool _like;

  NewsBox(this._title, this._text, {int num = 0, bool like = false}) {
    _num = num;
    _like = like;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        color: Colors.black12,
        height: 100.0,
        child: new Row(children: [
          new SizedBox(
              height: 100.0,
              width: 100.0,
              child: new IconButton(
                padding: new EdgeInsets.all(0.0),
                color: Colors.pinkAccent,
                icon: new Icon(
                    Icons.favorite,
                    color:Colors.pink,
                    size: 18.0
                ),
              )
          ),
          new Expanded(
              child: new Container(
                  padding: new EdgeInsets.all(
                      5.0
                  ),
                  child: new Column(
                      children: [
                        new Text(
                            _title,
                            style: new TextStyle(
                                fontSize: 20.0
                            ),
                            overflow: TextOverflow.ellipsis
                        ),
                        new Expanded(
                            child:new Text(
                              _text,
                              softWrap: true,
                              textAlign: TextAlign.justify,
                            )
                        )
                      ]
                  )
              )
          ),
          new NewsBoxFavourite(
              _num,
              _like
          )
        ])
    );

  }
}

void main() =>  runApp(
    new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(

            appBar: AppBar(title: Text('Question 3')),
            body: new NewsBox(
                'A new flutter example',
                '''Shows you how can you use stateful and stateless widgets together.''',
                num: 10)
        )
    )
);