import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

Future<SharedPreferences> prefsMock() async {
  const MethodChannel channel = MethodChannel(
    'plugins.flutter.io/shared_preferences',
  );

  channel.setMockMethodCallHandler((MethodCall methodCall) async {
    if (methodCall.method == 'getAll') {
      return <String, dynamic>{};
    }
    return null;
  });

  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs;
}