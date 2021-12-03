import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/src/widgets/logo.dart';

void main() {
  final widget = MaterialApp(home: Logo());
  testWidgets('Should render logo image and app name', (tester) async {
    await tester.pumpWidget(widget);
    final logoImageFinder =
        tester.widget<Image>(find.byType(Image)).image as AssetImage;
    final appNameFinder = find.text('scratch');
    expect(logoImageFinder.assetName, 'assets/icons/logo_icon.png');
    expect(appNameFinder, findsOneWidget);
  });
}
