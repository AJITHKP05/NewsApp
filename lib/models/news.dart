import 'dart:convert';

class News {
  final String author;
  final Source source;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;
  News({
    this.author,
    this.source,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  Map<String, dynamic> toMap() {
    return {
      'author': author,
      'source': source?.toMap(),
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }

  factory News.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return News(
      author: map['author'],
      source: Source.fromMap(map['source']),
      title: map['title'],
      description: map['description'],
      url: map['url'],
      urlToImage: map['urlToImage'],
      publishedAt: map['publishedAt'],
      content: map['content'],
    );
  }

  String toJson() => json.encode(toMap());

  factory News.fromJson(String source) => News.fromMap(json.decode(source));
}

class Source {
  final String id;
  final String name;

  Source(
    this.id,
    this.name,
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Source.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Source(
      map['id'],
      map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Source.fromJson(String source) => Source.fromMap(json.decode(source));
}
