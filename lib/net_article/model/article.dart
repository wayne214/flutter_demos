class Article {
  final String title;
  final String url;
  final String time;
  final String author;
  final String superChapterName;
  final String chapterName;

  const Article({
    required this.title,
    required this.url,
    required this.time,
    required this.author,
    required this.superChapterName,
    required this.chapterName,
  });

  factory Article.formMap(dynamic map) {
    return Article(
      title: map['title'] ?? '未知',
      url: map['link'] ?? '',
      time: map['niceDate'] ?? '',
      author: map['author'] ?? '未知',
      superChapterName: map['superChapterName'] ?? '未知',
      chapterName: map['chapterName'] ?? '未知',
    );
  }

  @override
  String toString() {
    return 'Article(title: $title, url: $url, time: $time)';
  }

}