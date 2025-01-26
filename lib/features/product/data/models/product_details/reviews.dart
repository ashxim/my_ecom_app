class Review {
  final String reviewerName;
  final String comment;
  final double rating;
  final String? reviewDate;

  const Review({
    required this.reviewerName,
    required this.comment,
    required this.rating,
    this.reviewDate,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      reviewerName: json['reviewerName'],
      comment: json['comment'],
      rating: (json['rating'] as num).toDouble(),
      reviewDate: json['reviewDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reviewerName': reviewerName,
      'comment': comment,
      'rating': rating,
      'reviewDate': reviewDate,
    };
  }
}
