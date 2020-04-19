import 'package:flutter/material.dart';
import 'package:flutter_skeleton/database/DBManager.dart';
import 'package:flutter_skeleton/screens/home.dart';
import 'package:flutter/foundation.dart';

void main() async{

  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: Home(),
  ));

  var db = await DBManager.instance.database;

}
