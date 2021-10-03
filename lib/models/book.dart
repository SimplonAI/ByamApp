class Book {
  final String title;
  final String cover;
  final String tags;
  final String authors;
  int? rating;

  Book(this.title, this.cover, this.tags, this.authors, {this.rating});
  Book.fromJson(Map<String, dynamic> json)
      : title = json["book_title"],
        cover = json["book_image_url"],
        tags = json["tags"],
        authors = json["book_authors"];

  Map<String, Object?> toJson() {
    return {
      "book_title": title,
      "cover": cover,
      "tags": tags,
      "authors": authors,
      "rating": rating,
    };
  }
}
