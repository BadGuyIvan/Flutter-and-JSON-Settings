import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_json/models/settings.dart';
import '../utils/theme.dart';
import "../utils/path.dart";

class SettingsWidget extends StatefulWidget {
  final DynamicTheme theme;
  final Path json;
  SettingsWidget({this.theme, this.json});

  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  Color pickerColor = Color(0xFF2196F3);
  Color currentColor = Color(0xFF2196F3);

  void onChangeColor(Color color) {
    setState(() {
      pickerColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  color: Theme.of(context) == null
                      ? currentColor
                      : Theme.of(context).primaryColor,
                  onPressed: () {
                    showDialog(
                      context: context,
                      child: AlertDialog(
                        title: Text('Pick a color!'),
                        content: SingleChildScrollView(
                          child: ColorPicker(
                            pickerColor: Theme.of(context) == null
                                ? pickerColor
                                : Theme.of(context).primaryColor,
                            onColorChanged: onChangeColor,
                            enableLabel: true,
                            pickerAreaHeightPercent: 0.8,
                          ),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Apply'),
                            onPressed: () {
                              setState(() {
                                currentColor = pickerColor;
                                Navigator.pop(context);
                              });

                              print('${widget.json}');
                                
                              Settings settings = Settings(currentColor.value.toString());
                              widget.json.writeJson(settings);

                              widget.theme.selectedTheme.add(
                                CustomTheme(
                                  ThemeData(
                                    primaryColor: currentColor,
                                    buttonTheme: ButtonThemeData(
                                      buttonColor: currentColor,
                                      textTheme: ButtonTextTheme.primary,
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              Text('Theme color')
            ],
          )
        ],
      ),
    );
  }
}
