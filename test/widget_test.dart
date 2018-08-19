import 'package:flutter_test/flutter_test.dart';
import 'package:boono_mobile/main.dart' as app;

void main() {
  testWidgets('app test', (WidgetTester tester) async {
    app.main();
    await tester.pumpWidget(new app.App());
    await tester.pumpWidget(new app.ErrorPage());
  });
}
