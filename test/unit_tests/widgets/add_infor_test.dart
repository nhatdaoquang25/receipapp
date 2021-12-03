import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/widgets/create_recipe/add_info.dart';
import 'package:mocktail/mocktail.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MyFakeType extends Fake implements Route {}

void main() {
  setUp(() => {registerFallbackValue(MyFakeType())});
  final widget = MaterialApp(
    home: Scaffold(body: AddInfo()),
  );
  testWidgets(
      'Should render [Serving Time], [Nutrition Facts], [Tags] text with correct text',
      (tester) async {
    await tester.pumpWidget(widget);
    final timeText = find.text('Serving Time');
    final nutritionText = find.text('Nutrition Facts');
    final tagsText = find.text('Tags');
    expect(tagsText, findsOneWidget);
    expect(nutritionText, findsOneWidget);
    expect(timeText, findsOneWidget);
  });
  testWidgets('Should render textFormField add info widgets ', (tester) async {
    await tester.pumpWidget(widget);
    final timeTextFormField = find.byType(TextFormField).first;
    final nutritionTextFormField = find.byType(TextFormField).last;
    final tagsTextFormField = find.byType(TextFormField).last;
    expect(timeTextFormField, findsOneWidget);
    expect(nutritionTextFormField, findsOneWidget);
    expect(tagsTextFormField, findsOneWidget);
  });
}
