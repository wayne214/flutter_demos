import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FourPage extends StatefulWidget {
  const FourPage({super.key});

  @override
  State<FourPage> createState() => _FourPageState();
}

class _FourPageState extends State<FourPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FourPage'),
      ),
      body: ConstrainedBox(constraints: const BoxConstraints.expand(), child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          const Positioned(left: 18.0,child: Text("I am jack"),),
          Container(
            color: Colors.red,
            child: const Text("hello world", style: TextStyle(color: Colors.blue),),
          ),

          const Positioned(top: 100.0,child: Text("your friend"),),

          const Column(
            children: [
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                alignment: WrapAlignment.start,
                children: [
                  Chip(
                    label: Text('Hamilton'),
                    avatar: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text('A'),
                    ),
                  ),
                  Chip(
                    label: Text('Lafayette'),
                    avatar: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text('M'),
                    ),
                  ),Chip(
                    label: Text('Mulligan'),
                    avatar: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text('H'),
                    ),
                  ),
                  Chip(
                    label: Text('Laurens'),
                    avatar: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text('j'),
                    ),
                  ),


                ],
              ),
            ],
          ),
        ],
      ),)




    );
  }
}
