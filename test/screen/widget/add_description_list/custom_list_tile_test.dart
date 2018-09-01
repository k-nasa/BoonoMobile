import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:boono_mobile/model/subscription_item.dart';
import 'package:boono_mobile/bloc/description_bloc_provider.dart';
import 'package:boono_mobile/screen/widget/add_description_list/custom_list_tile.dart';

void main() {
  const MethodChannel('com.tekartik.sqflite')
      .setMockMethodCallHandler((MethodCall methodCall) async {
    if (methodCall.method == 'openDatabase') {
      Database db;
      return db;
    }
    if (methodCall.method == 'query') {
      return <List>[];
    }

    return null;
  });

  const MethodChannel('plugins.flutter.io/path_provider')
      .setMockMethodCallHandler((MethodCall methodCall) async {
    return '/dummy/path';
  });
  testWidgets('CustomListTile', (WidgetTester tester) async {
    SubscriptionItem dummySubItem = SubscriptionItem(
      id: 999999,
      content: '約束のネバーランド',
      type: 'TitleItem',
    );

    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
      body: SubscriptionBlocProvider(
          child: CustomListTile(
        subItem: dummySubItem,
      )),
    )));

    final Finder openMenuButton = find.byIcon(Icons.close);
    final Finder deleteButton = find.byIcon(Icons.delete);
    expect(openMenuButton, findsOneWidget);
    expect(deleteButton, findsNothing);

    await tester.tap(openMenuButton);
    await tester.pump(const Duration(milliseconds: 1000));
    expect(deleteButton, findsOneWidget);

    await tester.tap(deleteButton);
    await tester.pump(const Duration(milliseconds: 1000));
  });
}
