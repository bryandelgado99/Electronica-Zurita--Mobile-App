import 'package:electronica_zurita/utilities/navigator_rules.dart';
import 'package:flutter/material.dart';

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
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(seconds: 8));

    setState(() {
      _isLoading = false;
    });

    finishOnBoarding(context);
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
        color: Colors.white,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height/1.85,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.path),
                  scale: 2.5
                )
              ),
            ),
            Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height/2.1,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.only(
                     topLeft: Radius.circular(50)
                   ),
                   color: widget.color
                 ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      children: [
                        SizedBox(height: 82),
                        Text(widget.title, style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20), textAlign: TextAlign.center,),
                        SizedBox(height: 40),
                        Text(widget.description, style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16, color: Colors.white), textAlign: TextAlign.center)
                      ],
                    ),
                  ),
              )
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: widget.isSkipped
                  ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    TextButton(onPressed: (){}, child: Text("Omitir", style: TextStyle(color: Colors.white70),)),
                    GestureDetector(
                      onTap: widget.onTab,
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: FilledButton(
                          onPressed: widget.onTab,
                          child: Icon(Icons.arrow_forward_rounded, size: 18,),
                        ),
                      ),
                    )
                  ],
                )
                : SizedBox(
                  height: 46,
                  child:  _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : MaterialButton(
                    onPressed: _onNextPressed,
                    child: Text("Siguiente"),
                    shape: RoundedRectangleBorder(borderRadius:BorderRadius.all( Radius.circular(25))),
                    color: Colors.amber,
                  ),
                )
              )
            )
          ],
        ),
    );
  }
}
