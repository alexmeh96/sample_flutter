/// Summarized information of a character.
class Character {
  Character({
    this.id,
    this.name,
    this.pictureUrl,
  });

  factory Character.fromJson(Map<String, dynamic> json) =>
      Character(
        id: json['char_id'],
        name: json['name'],
        pictureUrl: json['img'],
      );

  final int id;
  final String name;
  final String pictureUrl;
}
