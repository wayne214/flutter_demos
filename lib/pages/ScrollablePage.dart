import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class ScrollablePage extends StatefulWidget {
  const ScrollablePage({super.key});

  @override
  State<ScrollablePage> createState() => _ScrollablePageState();
}

class _ScrollablePageState extends State<ScrollablePage> {
  static const loadingTag = "##loading##";

  var _words = <String>[loadingTag];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _retrieveData();
  }

  void _retrieveData() {
    Future.delayed(const Duration(seconds: 2)).then((e) {
      setState(() {
        _words.insertAll(_words.length - 1,
            generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('列表'),),
      body: Column(
        children: [
          const Text('商品列表', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
          Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  // 如果到了表尾
                  if (_words[index] == loadingTag) {
                    //
                    if (_words.length - 1 < 100) {
                      // 获取数据
                      _retrieveData();
                      // 添加一个 loading
                      return Container(
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: const SizedBox(
                          width: 24.0,
                          height: 24.0,
                          child: CircularProgressIndicator(strokeWidth: 2.0),
                        ),
                      );
                    } else {
                      return Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(16.0),
                          child: const Text(
                            "没有更多了",
                            style: TextStyle(color: Colors.grey),
                          ));
                    }
                  }

                  return ListTile(title: Text(_words[index]),);
                },
                separatorBuilder: (context, index) => const Divider(
                  height: 0.1,
                ),
                itemCount: _words.length,
              ))
        ],
      ),
    );
  }
}
