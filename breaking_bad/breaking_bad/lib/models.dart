class Character {
  String name;
  String imgUrl;
  int id;

  Character({
    this.name = 'default',
    this.imgUrl = 'url',
    this.id = 0,
  });

  static Character fromJson(Map<String, dynamic> json) {
    return Character(
        name: json['name'], imgUrl: json['img'], id: json['char_id']);
  }
}
