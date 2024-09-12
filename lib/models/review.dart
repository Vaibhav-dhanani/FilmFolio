class Review {
  String id;
  String userId;
  String reviewText;
  String contentId;
  DateTime date;

  Review({
    required this.id,
    required this.userId,
    required this.reviewText,
    required this.contentId,
    DateTime? date,
  }) : date = date ?? DateTime.now();

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'reviewText': reviewText,
    'contentId': contentId,
    'date': date.toIso8601String(),
  };

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      reviewText: json['reviewText'] ?? '',
      contentId: json['contentId'] ?? '',
      date: json['date'] != null
          ? DateTime.parse(json['date'])
          : DateTime.now(),
    );
  }
}
