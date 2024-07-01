import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Privacypolit extends StatefulWidget {
  const Privacypolit({super.key});

  @override
  State<Privacypolit> createState() => PrivacypolitState();
}

class PrivacypolitState extends State<Privacypolit> {

  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://www.app-privacy-policy.com/live.php?token=MKKYJEMlUIXy9dbXax3mIkNhuaTxInfA'));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: double.maxFinite,
        height: 400, // Adjust the height as needed
        child: WebViewWidget(
          controller: _controller,
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cerrar'),
        ),
      ],
    );
  }
}
