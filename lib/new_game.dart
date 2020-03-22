import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'env.dart' as env;

class NewGamePage extends StatefulWidget {
  @override
  _NewGamePageState createState() => _NewGamePageState();
}

class _NewGamePageState extends State<NewGamePage> {
  var playerId = '';
  var authToken = '';
  var credential = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<http.Response>(
      // Challenge request: https://docs.gamesparks.com/api-documentation/rest-apis/requests.html#!/Multiplayer/post_rs_credential_secret_CreateChallengeRequest
      future: http.post(
          env.API_KEY +
              '.' +
              '.' +
              env.STAGE +
              '/rs/' +
              credential +
              '/' +
              env.API_SECRET +
              '/CreateChallengeRequest?playerId=' +
              playerId +
              '&authToken=' +
              authToken,
          body: {}),
      builder: (BuildContext context, AsyncSnapshot<http.Response> response) {
        List<Widget> children;

//        response = {
//          "challengeInstanceId": "string",
//          "requestId": "string",
//          "scriptData": {
//            "myKey": "string",
//            "myValue": {}
//          }
//        }

        if (response.hasData) {
          children = <Widget>[
            RaisedButton(
              child: Text("Start game"),
              onPressed: () => {},
            )
          ];
        } else if (response.hasError) {
          children = <Widget>[
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${response.error}'),
            )
          ];
        } else {
          children = <Widget>[
            SizedBox(
              child: CircularProgressIndicator(),
              width: 60,
              height: 60,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Creating game...'),
            )
          ];
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          ),
        );
      },
    );
  }
}
