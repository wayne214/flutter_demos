import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demos/net_article/api/article_api.dart';
import 'package:flutter_demos/net_article/model/article.dart';

import 'article_detail_page.dart';

class ArticleContent extends StatefulWidget {
  const ArticleContent({super.key});

  @override
  State<ArticleContent> createState() => _ArticleContentState();
}

class _ArticleContentState extends State<ArticleContent> {
  List<Article> _articles = [];
  ArticleApi api = ArticleApi();

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadArticles();
  }

  void _loadArticles() async {
    _loading = true;
    setState(() {});
    _articles = await api.getArticles(0);
    _loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
        header: const ClassicHeader(
          dragText: '下载加载',
          armedText: '释放刷新',
          readyText: '开始加载',
          processingText: '正在加载',
          processedText: '刷新成功',
        ),
        footer: const ClassicFooter(processedText: '正在加载'),
        onRefresh: _onRefresh,
        onLoad: _onLoadMore,
        child: ListView.builder(
          itemExtent: 80,
          itemCount: _articles.length,
          itemBuilder: _buildItemByIndex,
        ));
  }

  void _jumpToPage(Article article){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ArticleDetailPage(article: article)));
  }

  void _onRefresh() async {
    _articles = await api.getArticles(0);
    setState(() {});
  }

  void _onLoadMore() async {
    _articles = await api.getArticles(0);
    setState(() {});
  }

  Widget _buildItemByIndex(BuildContext context, int index) {
    return Text("data");
  }
}
