import 'package:flutter_test/flutter_test.dart';
import 'package:english_learn_app/main.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const EnglishLearnApp());
    expect(find.text('English'), findsOneWidget);
    expect(find.text('Learn'), findsOneWidget);
  });
}
