import 'package:electronica_zurita/app/views/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

void main() {
  testWidgets('Prueba A: Verificación de inicio de sesión', (WidgetTester tester) async {
    // Configura el MockClient
    final client = MockClient();
    final testUri = Uri.parse('https://example.com/login');  // Reemplaza con tu URL de prueba

    when(client.post(testUri, headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => http.Response('{"token": "dummyToken", "_id": "dummyId"}', 200));

    // Construye la aplicación
    await tester.pumpWidget(
      MaterialApp(
        home: LoginScreen(),  // Asegúrate de que esta es la pantalla de inicio de sesión correcta
      ),
    );

    // Verifica que los elementos de la pantalla de inicio de sesión estén presentes
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('Correo electrónico'), findsOneWidget);
    expect(find.text('Contraseña'), findsOneWidget);
    expect(find.text('Ingresar'), findsOneWidget);
    expect(find.text('¿Olvidaste tu contraseña?'), findsOneWidget);
    expect(find.text('¿Necesitas un trabajo?'), findsOneWidget);

    // Introduce texto en los campos de correo electrónico y contraseña
    await tester.enterText(find.byType(TextFormField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'password123');

    // Toca el botón de ingresar
    await tester.tap(find.text('Ingresar'));
    await tester.pumpAndSettle();

    // Verifica que se haya realizado la solicitud HTTP
    verify(client.post(testUri, headers: anyNamed('headers'), body: anyNamed('body'))).called(1);

  });
}
