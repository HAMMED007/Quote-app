class Quote {
  String quote;
  String author;
  String id = '';
  bool isFavourite = false;
  Quote({required this.quote, required this.author, required this.id});
  factory Quote.fromJson(Map<String, dynamic> json, String quoteId) {
    return Quote(
      quote: json['quote'],
      author: json['author'],
      id: quoteId,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'quote': quote,
      'author': author,
    };
  }
}
