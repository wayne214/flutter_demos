import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
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
    if (_loading) {
      return const Center(
          child: Wrap(
        spacing: 10,
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          CupertinoActivityIndicator(),
          Text(
            '数据加载中，请稍后...',
            style: TextStyle(color: Colors.grey),
          )
        ],
      ));
    }

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

  void _jumpToPage(Article article) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ArticleDetailPage(article: article)));
  }

  void _onRefresh() async {
    _articles = await api.getArticles(0);
    setState(() {});
  }

  void _onLoadMore() async {
    int nextPage = _articles.length ~/ 20;
    List<Article> newList = await api.getArticles(nextPage);
    _articles.addAll(newList);
    setState(() {});
  }

  Widget _buildItemByIndex(BuildContext context, int index) {
    return ArticleItem(article: _articles[index], onTap: _jumpToPage);
  }
}

class ArticleItem extends StatelessWidget {
  final Article article;
  final ValueChanged<Article> onTap;

  const ArticleItem({super.key, required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(article),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Text(
                    article.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  )),
                ],
              ),
              const SizedBox(height: 4),
             
              Expanded(
                  child: Row(
                children: [
                  Text('作者：${article.author}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('分类：${article.superChapterName}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text('时间：${article.time}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
