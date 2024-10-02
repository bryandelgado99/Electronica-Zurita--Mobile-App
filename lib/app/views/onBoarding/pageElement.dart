import 'package:electronica_zurita/utilities/navigator_rules.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Login.dart';

class pageElement extends StatefulWidget {
  const pageElement({super.key, required this.title, required this.description, required this.isSkipped, required this.path, required this.onTab, required this.color});

  final Color color;
  final String title;
  final String description;
  final bool isSkipped;
  final String path;
  final VoidCallback onTab;

  @override
  State<pageElement> createState() => _pageElementState();
}

class _pageElementState extends State<pageElement> {

  bool _isLoading = false;

  void _onNextPressed() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoading = true;
    });

    await prefs.setBool('showOnBoardScreen', false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );

    setState(() {
      _isLoading = false;
    });

    finishOnBoarding(context);
  }

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: screenHeight * 0.50,
            child: Center(
              child: Image.asset(widget.path, scale: 2.15),
            ),
          ),
          Container(
            height: screenHeight * 0.50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.title, style: TextStyle(fontWeight: FontWeight.w600, color: widget.color, fontSize: 20), textAlign: TextAlign.center,),
                  SizedBox(height: 40),
                  Text(widget.description, style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16, color: Colors.black), textAlign: TextAlign.center),
                  SizedBox(height: 40),
                  actionComponents(),
                  SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget actionComponents(){
    return SizedBox(
      child: widget.isSkipped ?
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: widget.onTab,
            child: Container(
              padding: EdgeInsets.all(16),
              child: IconButton.filled(
                onPressed: widget.onTab,
                icon: Icon(Icons.arrow_forward_rounded, size: 20, color: Colors.white),
              ),
            ),
          )
        ],
      )
          :
      SizedBox(
          width: MediaQuery.of(context).size.width,
          child:  _isLoading
              ? Center(child: CircularProgressIndicator())
              : FilledButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(widget.color)
                ),
                onPressed: _onNextPressed,
                child: Text("Empecemos")
          )
      ),
    );
  }
}
