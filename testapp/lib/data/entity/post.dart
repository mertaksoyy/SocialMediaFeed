class Post {
  final int post_id;
  final DateTime post_date;
  final String post_headerText;
  final String post_bodyText;
  final String? imagePath;

  Post(
      {required this.post_id,
      required this.post_date,
      required this.post_headerText,
      required this.post_bodyText,
      this.imagePath});
}
