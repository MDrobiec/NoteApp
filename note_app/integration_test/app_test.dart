import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:integration_test/integration_test.dart';

import 'package:note_app/main.dart' as app;

void main() {
  group('App test', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    testWidgets('new note add test', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      final noteName = find.byKey(const Key("noteName"));
      final noteContents = find.byKey(const Key("noteContents"));
      final saveNewNote = find.byKey(const Key("saveNewNote"));
      final floatingActionButton =
          find.byKey(const Key("floatingActionButton"));

      await tester.tap(floatingActionButton);
      await tester.pumpAndSettle();

      await tester.enterText(noteName, "New note");
      await tester.enterText(noteContents, "New note from uni test");
      await tester.pumpAndSettle();
      await tester.tap(saveNewNote);
    });
  });
}
