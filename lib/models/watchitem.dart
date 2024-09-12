class WatchlistItem {
  final String? id;
  final String contentId;
  final DateTime dateAdded;

  WatchlistItem({
    required this.id,
    required this.contentId,
    required this.dateAdded,
  });

  Map<String, dynamic> toJson() => {
    'contentId': contentId,
    'dateAdded': dateAdded.toLocal(),
  };
}