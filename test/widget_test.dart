import 'package:flutter_test/flutter_test.dart';
import 'package:boono_mobile/main.dart' as app;
import 'helper/shared_preferences_helper.dart';

void main() async {
  await prefsMock();

  testWidgets('app test', (WidgetTester tester) async {
    app.main();
    await tester.pumpWidget(new app.App());
    await tester.pumpWidget(new app.ErrorPage());
  });
}
