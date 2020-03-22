import 'package:deal/new_game.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: Container(
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text('Welcome to Deal!'),
                    RaisedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => NewGamePage()));
                      },
                      child: Text('New game'),
                    ),
                    RaisedButton(
                      onPressed: () async {
                      },
                      child: Text('Join game'),
                    ),
                  ]
                )
            )
        )
    );
  }
}