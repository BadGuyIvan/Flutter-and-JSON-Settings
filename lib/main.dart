import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_json/widgets/settings.widget.dart';

import 'models/settings.dart';
import 'utils/theme.dart';
import "./utils/path.dart";

void main() async{
  var settings;
  await Path().readJson().then((json) => settings = json);
  runApp(MyApp(setting: settings,));
}

class MyApp extends StatelessWidget {
  final DynamicTheme theme = DynamicTheme();
  final setting;

  MyApp({this.setting});

  @override
  Widget build(BuildContext context) {
    Settings set = Settings.fromJson(jsonDecode(setting));

    var defaultTheme = ThemeData(
      primaryColor: Color(int.parse(set.color)),
      buttonTheme: ButtonThemeData(
        buttonColor: Color(int.parse(set.color)),
        textTheme: ButtonTextTheme.primary,
      ),
    );

    return StreamBuilder(
      stream: theme.themeDataStream,
      initialData: defaultTheme,
      builder: (BuildContext context, AsyncSnapshot<ThemeData> snapshot) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: snapshot.data,
          home: MyHomePage(theme: theme),
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  final DynamicTheme theme;

  MyHomePage({this.theme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JSON store'),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: Text('Text'),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SettingsWidget(
                      theme: theme,
                      json: Path(),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
