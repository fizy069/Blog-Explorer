class Blog {
  final String id;
  final String title;
  final String imageUrl;

  Blog({required this.id, required this.title, required this.imageUrl});

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'],
      title: json['title'],
      imageUrl: json['image_url'],
    );
  }
}
