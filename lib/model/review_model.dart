class Review {
  final String userId;
  final String review;
  final String movieId;
  final String subject;
  final String detail;

  Review({
    required this.userId,
    required this.review,
    required this.movieId,
    required this.subject,
    required this.detail,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      userId: json['userId'],
      review: json['review'],
      movieId: json['movieId'],
      subject: json['subject'],
      detail: json['detail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'review': review,
      'movieId': movieId,
      'subject': subject,
      'detail': detail,
    };
  }
}
