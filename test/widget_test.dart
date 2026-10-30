
import 'package:flutter_test/flutter_test.dart';
import 'package:bookly/main.dart';

void main() {
  testWidgets('Bookly app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const Bookly());
    await tester.pump();
  });
}
