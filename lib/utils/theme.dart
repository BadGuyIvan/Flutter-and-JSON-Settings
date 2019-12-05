import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class CustomTheme {
  final ThemeData data;

  const CustomTheme(this.data);
}

class DynamicTheme {
  final Stream<ThemeData> themeDataStream;
  final Sink<CustomTheme> selectedTheme;

  factory DynamicTheme() {
    final PublishSubject<CustomTheme> selectedTheme =
        PublishSubject<CustomTheme>();
    final themeDataStream = selectedTheme.distinct().map((theme) => theme.data);
    return DynamicTheme._(themeDataStream, selectedTheme);
  }
  const DynamicTheme._(this.themeDataStream, this.selectedTheme);
}
