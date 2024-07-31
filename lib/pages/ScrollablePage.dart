import 'package:english_words/english_words.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ScrollablePage extends StatefulWidget {
  const ScrollablePage({super.key});

  @override
  State<ScrollablePage> createState() => _ScrollablePageState();
}

class _ScrollablePageState extends State<ScrollablePage> {
  static const loadingTag = "##loading##";

  var _words = <String>[loadingTag];

  final ScrollController _scrollController = ScrollController();

  bool showToTopBtn = false; // 是否显示"返回到顶部"

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _retrieveData();

    _scrollController.addListener(() {
      if (kDebugMode) {
        print(_scrollController.offset);
      }

      if (_scrollController.offset < 1000 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_scrollController.offset >= 1000 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  @override
  void dispose() {
    // 避免内存泄漏，调用_scrollController.dispose();
    _scrollController.dispose();
    super.dispose();
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
      appBar: AppBar(
        title: const Text('列表'),
      ),
      body: Column(
        children: [
          const Text(
            '商品列表',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          Expanded(
              child: ListView.separated(
            controller: _scrollController,
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

              return ListTile(
                title: Text(_words[index]),
              );
            },
            separatorBuilder: (context, index) => const Divider(
              height: 0.1,
            ),
            itemCount: _words.length,
          ))
        ],
      ),
      floatingActionButton: !showToTopBtn
          ? null
          : FloatingActionButton(
              child: const Icon(Icons.arrow_upward),
              onPressed: () {
                _scrollController.animateTo(.0,
                    duration: const Duration(milliseconds: 200), curve: Curves.ease);
              },
            ),
    );
  }
}
