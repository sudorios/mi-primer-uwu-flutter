import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:appepexamenpo/main.dart'; // Asegúrate de que esta ruta sea correcta

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Construye la app y dispara un frame.
    await tester.pumpWidget(const MyApp());

    // Verifica que el contador empiece en 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Toca el ícono '+' y actualiza el frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verifica que el contador haya incrementado.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
