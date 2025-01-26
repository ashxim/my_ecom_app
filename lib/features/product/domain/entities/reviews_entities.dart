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
}
