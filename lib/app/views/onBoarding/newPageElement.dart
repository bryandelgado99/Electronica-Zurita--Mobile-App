import 'package:flutter/material.dart';

class NewPageElement extends StatefulWidget {
  const NewPageElement({
    super.key,
    required this.title,
    required this.description,
    required this.isSkipped,
    required this.path,
    required this.onTab,
    required this.color,
  });

  final Color color;
  final String title;
  final String description;
  final bool isSkipped;
  final String path;
  final VoidCallback onTab;

  @override
  _NewPageElementState createState() => _NewPageElementState();
}

class _NewPageElementState extends State<NewPageElement> {

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
          SizedBox(
            height: screenHeight * 0.50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: widget.color,
                          fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    Text(
                      widget.description,
                      style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                          color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    _composeAction(context),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _composeAction(BuildContext context) {
    return SizedBox(
        child:
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilledButton(
                onPressed: (){
                  showDialog(
                      context: context,
                      builder: (context){
                        return onCallAddDialog(context);
                      }
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(Icons.widgets_rounded),
                    SizedBox(width: 12,),
                    Text("Agregar Widget")
                  ],
                )
            ),
            GestureDetector(
              onTap: widget.onTab,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: IconButton.filled(
                  onPressed: widget.onTab,
                  icon: const Icon(Icons.arrow_forward_rounded, size: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        )
    );
  }
}

AlertDialog onCallAddDialog(BuildContext context){
  return AlertDialog(
    title: const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.widgets_rounded),
        SizedBox(width: 12,),
        Text("Agregar Widget", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),)
      ],
    ),
    content: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 25,),
        Center(
          child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24)
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Image.asset('assets/images/logo.png', width: 90,),
              )
          ),
        ),
        const SizedBox(height: 30,),
        const Text("Vas a agregar el widget de Electrónica Zuita a tu pantalla de inicio."),
        const SizedBox(height: 15,),
        const Text("¿Deseas continuar?", style: TextStyle(fontWeight: FontWeight.w500),)
      ],
    ),
    actionsAlignment: MainAxisAlignment.end,
    actions: [
      TextButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: const Text("Cancelar")
      ),
      TextButton(
        onPressed: (){},
        child: const Text("Agregar"),
      )
    ],
  );
}