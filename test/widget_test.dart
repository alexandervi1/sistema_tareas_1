import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sistema_tareas_1/main.dart'; // Asegúrate de importar tu aplicación

void main() {
  testWidgets('Prueba de la pantalla de inicio de sesión', (WidgetTester tester) async {
    // Construye la aplicación y desencadena un frame.
    await tester.pumpWidget( MyApp());

    // Verifica que el texto "Iniciar Sesión" esté presente en la pantalla.
    expect(find.text('Iniciar Sesión'), findsOneWidget);

    // Encuentra el campo de texto de usuario y escribe un valor.
    await tester.enterText(find.byType(TextFormField).at(0), 'testuser');

    // Encuentra el campo de texto de contraseña y escribe un valor.
    await tester.enterText(find.byType(TextFormField).at(1), 'password123');

    // Encuentra el botón de inicio de sesión y tócala.
    await tester.tap(find.byType(ElevatedButton));
    
    // Espera que se reconstruya la pantalla.
    await tester.pump();

    // Verifica que la navegación haya sucedido (esto depende de tu implementación de navegación).
    expect(find.text('Bienvenido a la pantalla principal'), findsOneWidget);
  });
}
