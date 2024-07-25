import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demos/pages/SecondPage.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('第一页'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.all(10.0), child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

               Image(
                  image: AssetImage('images/iceberg.jpg'),
                  width: 78,
                  height: 78,
                  fit: BoxFit.fill,
                ),
                SizedBox(width: 10,),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "乐享生鲜店",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '关注',
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "5分",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          "营业时间 07：00-22：00",
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    )
                  ],
                )
              ],
            )),

            Container(
              margin: const EdgeInsets.only(top: 50.0, left: 120.0),
              constraints: const BoxConstraints.tightFor(width: 200.0, height: 150.0),//卡片大小
              decoration: const BoxDecoration(  //背景装饰
                gradient: RadialGradient( //背景径向渐变
                  colors: [Colors.red, Colors.orange],
                  center: Alignment.topLeft,
                  radius: .98,
                ),
                boxShadow: [
                  //卡片阴影
                  BoxShadow(
                    color: Colors.black54,
                    offset: Offset(2.0, 2.0),
                    blurRadius: 4.0,
                  )
                ],
              ),
              transform: Matrix4.rotationZ(.2),//卡片倾斜变换
              alignment: Alignment.center, //卡片内文字居中
              child: const Text(
                //卡片文字
                "5.20", style: TextStyle(color: Colors.white, fontSize: 40.0),
              ),
            )
          ],
        ));
  }
}
