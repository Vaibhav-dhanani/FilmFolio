class UserContent {
  final String userId;
  final String contentId;
  final DateTime createdAt;

  UserContent({
    required this.userId,
    required this.contentId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();


  Map<String, dynamic> toJson() => {
    'userId': userId,
    'contentId': contentId,
    'createdAt': createdAt.toIso8601String(),
  };

  factory UserContent.fromJson(Map<String, dynamic> json) {
    return UserContent(
      userId: json['userId'] as String,
      contentId: json['contentId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
