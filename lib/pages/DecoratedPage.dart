import 'package:flutter/material.dart';

class DecoratedPage extends StatefulWidget {
  const DecoratedPage({super.key});

  @override
  State<DecoratedPage> createState() => _DecoratedPageState();
}

class _DecoratedPageState extends State<DecoratedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('DecoratedBox')),
      body: Column(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.red, Colors.orange.shade700]),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue, width: 2),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black54,
                      offset: Offset(2.0, 2.0),
                      blurRadius: 4.0)
                ]),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
              child: Text(
                "login",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          // Container(
          //   color: Colors.black,
          //   child: Transform(
          //     alignment: Alignment.topRight,
          //     transform: Matrix4.skewY(0.3),
          //     child: Container(
          //       padding: const EdgeInsets.all(8),
          //       color: Colors.deepOrange,
          //       child: const Text('Apartment for rend!'),
          //     ),
          //   ),
          // ),

          // wContainer(BoxFit.none),
          // const Text("Wendux"),
          // wContainer(BoxFit.contain),
          // const Text('Flutter中国')

        ],
      ),
    );
  }

  Widget wContainer(BoxFit boxFit) {
    return Container(
      width: 50,
      height: 50,
      color: Colors.red,
      child: FittedBox(
        fit: boxFit,
        child: Container(
          width: 60,
          height: 70,
          color: Colors.blue,
        ),
      ),
    );
  }
}
