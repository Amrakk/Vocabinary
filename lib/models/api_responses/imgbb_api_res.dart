class ImgbbResponse {
  String? image;
  String? thumb;
  String? medium;

  ImgbbResponse({this.image, this.thumb, this.medium});

  factory ImgbbResponse.fromMap(Map<String, dynamic> map) {
    return ImgbbResponse(
      image: map['image']['url'] ?? '',
      thumb: map['thumb']['url'] ?? '',
      medium: map['medium']['url'] ?? '',
    );

  }
}
