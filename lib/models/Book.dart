class Book {
  final String title;
  final List<String> authorName;
  final List<String> firstSentence;
  final int ratingsCount;
  final int numberOfPagesMedian;
  final int firstPublishYear;
  final String ebookAccess;
  final String key;

  const Book({
    required this.title,
    required this.authorName,
    required this.firstSentence,
    required this.ratingsCount,
    required this.numberOfPagesMedian,
    required this.firstPublishYear,
    required this.ebookAccess,
    required this.key,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] ?? '',
      authorName: (json['author_name'] as List<dynamic>?)
              ?.map((author) => author.toString())
              .toList() ??
          [],
      firstSentence: (json['first_sentence'] as List<dynamic>?)
              ?.map((sentence) => sentence.toString())
              .toList() ??
          [],
      ratingsCount: json['ratings_count'] ?? 0,
      numberOfPagesMedian: json['number_of_pages_median'] ?? 0,
      firstPublishYear: json['first_publish_year'] ?? 0,
      ebookAccess: json['ebook_access'] ?? 'Unknown',
      key: json['key'] ?? '',
    );
  }
}
