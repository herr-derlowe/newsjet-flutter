const String tableName = "newslinks";
const String idColumn = "id";
const String titleColumn = "title";
const String summaryColumn = "summary";
const String descriptionColumn = "description";
const String linkColumn = "url";

class NewsLink {
  final int? id;
  final String title;
  final String? summary;
  final String link;
  
  NewsLink({
    this.id,
    required this.title,
    required this.link,
    this.summary,
  });

  // object can assume things about the data type, throwing errors in the linter
  Map<String, Object?> toMap() {
    return {
      "id": id,
      "title": title,
      "summary": summary,
      "url": link
    };
  }

  static NewsLink fromMap(Map<String, Object?> map) {
    return NewsLink(
      id: map[idColumn] as int?,
      title: map[titleColumn] == null ? "" : map[titleColumn] as String,
      summary: map[summaryColumn] as String?,
      link: map[linkColumn] as String
    );
  }

  // dynamic doesn't assume anything about the data type
  static NewsLink fromJson(Map<String, dynamic> json) => NewsLink(
    title: json[titleColumn] as String,
    summary: json[summaryColumn] ?? json[descriptionColumn],
    link: json[linkColumn] as String);
}