import 'package:flutter_test/flutter_test.dart';
import 'package:boono_mobile/main.dart';

void main() {
  testWidgets('app test', (WidgetTester tester) async {
    await tester.pumpWidget(new App());
  });
}
