
import 'dart:convert';
import 'dart:io';

import 'package:flutter_json/models/settings.dart';
import 'package:path_provider/path_provider.dart';

class Path {
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/settings.json');
  }

  Future<File> writeJson(Settings settings) async {
    final file = await _localFile;
    return file.writeAsString(jsonEncode(settings));
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<String> readJson() async {
    try {
      final file = await _localFile;
      return file.readAsStringSync();
    } catch (e) {
      // If encountering an error, return 0
      return null;
    }
  }
}
