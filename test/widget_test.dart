import 'package:flutter_test/flutter_test.dart';
import 'package:homefit/app/homefit_app.dart';

void main() {
  testWidgets('shows the HomeFit home screen', (tester) async {
    await tester.pumpWidget(const HomeFitApp());
    expect(find.text('Zeit für dich.'), findsOneWidget);
  });
}
