class WikiArticle {
  final String title;
  final String extract;
  final String? desc;
  final String? thumbnailUrl;
  final String contentUrl;

  WikiArticle({
    required this.title,
    required this.extract,
    required this.desc,
    required this.thumbnailUrl,
    required this.contentUrl,
  });

  factory WikiArticle.fromJson(Map<String, dynamic> json){
    return WikiArticle(
        title: json['title'] ?? '',
        extract: json['extract'] ?? '',
        desc: json['description'],
        thumbnailUrl: json['thumbnail']?['source'],
        contentUrl: json['content_urls']?['desktop']?['page'] ?? '',
    );
  }
}