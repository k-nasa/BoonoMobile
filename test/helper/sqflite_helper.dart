import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

MethodChannel sqfliteMock() {
  const MethodChannel sqfliteChannel = MethodChannel('com.tekartik.sqflite');

  sqfliteChannel.setMockMethodCallHandler((MethodCall methodCall) async {
    if (methodCall.method == 'openDatabase') {
      Database db;
      return db;
    }
    if(methodCall.method == 'query') {
      return <List>[];
    }

    return null;
  });

  const MethodChannel('plugins.flutter.io/path_provider').setMockMethodCallHandler((MethodCall methodCall) async {
    return '/dummy/path';
  });

  return sqfliteChannel;
}
