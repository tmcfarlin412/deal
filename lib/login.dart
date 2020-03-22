import 'package:deal/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart' as shared_prefs;
import 'package:http/http.dart' as http;
import 'env.dart' as env;

class LoginPage extends StatelessWidget {
  
  Future getAuthToken() {
    return shared_prefs.SharedPreferences.getInstance().then((prefs) {
      return prefs.get('AUTH_TOKEN');
    }).then((authToken) {
      if (authToken == null) {
        return registrationRequest().then((response) {
          return response.body.authToken;
        });
      } else {
        return authToken;
      }
    });
  }

  Future registrationRequest () {
    return http.post('TODO');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<http.Response>(
      future: getAuthToken(),
      builder: (BuildContext context, AsyncSnapshot<http.Response> response) {
        List<Widget> children;
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
