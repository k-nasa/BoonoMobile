import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:boono_mobile/screen/add_description_list.dart';
import 'package:boono_mobile/screen/widget/add_description_list/type_select_field.dart';
import 'package:boono_mobile/screen/widget/add_description_list/subscription_list_view.dart';

void main() {
  testWidgets('AddSubscriptionItemPage', (WidgetTester tester) async {
    await tester.pumpWidget(
        MaterialApp(
            home: Scaffold(
                body: AddSubscriptionItemPage()
            )
        )
    );

    final Finder inputText = find.byType(TextFormField);
    final Finder submitButton = find.byIcon(Icons.send);
    final Finder typeSelect = find.byType(TypeSelectFieldContent);
    final Finder listContainer = find.byType(SubscriptionListView);

    expect(inputText, findsOneWidget);
    expect(submitButton, findsOneWidget);
    expect(typeSelect, findsNothing);
    expect(find.text('購読リストに追加'), findsOneWidget);

    // フォームのフォーカス時にセレクトフィールドが表示される
    await tester.showKeyboard(inputText);
    expect(typeSelect, findsOneWidget);

    // リストをタップするとセレクトフィールドが消える
    await tester.tap(listContainer);
    await tester.pump(const Duration(milliseconds: 1000));
    expect(typeSelect, findsNothing);

    // 入力した内容でリストが保存される
    await tester.enterText(inputText, 'hogehoge');
    expect(find.text('hogehoge'), findsOneWidget);
    await tester.tap(submitButton);
    await tester.pump(const Duration(milliseconds: 1000));
    expect(typeSelect, findsNothing);
  });
}