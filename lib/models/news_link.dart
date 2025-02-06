const String tableName = "newslinks";
const String idColumn = "id";
const String titleColumn = "title";
const String summaryColumn = "summary";
const String descriptionColumn = "description";
const String linkColumn = "url";

class NewsLink {
  final int id;
  final String title;
  final String? summary;
  final String link;
  
  NewsLink({
    required this.id,
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
      "link": link
    };
  }

  // dynamic doesn't assume anything about the data type
  static NewsLink fromJson(Map<String, dynamic> json) => NewsLink(
    id: json[idColumn] as int, 
    title: json[titleColumn] as String,
    summary: json[summaryColumn] ?? json[descriptionColumn],
    link: json[linkColumn] as String);
}