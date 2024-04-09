import 'package:flutter/foundation.dart';

class PokeListPart {
  final String name;
  final int id;
  final Uint8List? image;

  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

  PokeListPart({this.image, required this.name, required this.id});

  factory PokeListPart.fromJson(Map<String, dynamic> json) {
    final nameLowerCase = json['name'] as String;
    final name = nameLowerCase.replaceFirst(
      nameLowerCase[0],
      nameLowerCase[0].toUpperCase(),
    );
    final id = int.parse(json['url'].toString().split('/')[6]);
    return PokeListPart(name: name, id: id);
  }

  factory PokeListPart.fromDbJson(Map<String, dynamic> json) {
    final nameLowerCase = json['name'] as String;
    final name = nameLowerCase.replaceFirst(
      nameLowerCase[0],
      nameLowerCase[0].toUpperCase(),
    );
    final id = json['id'];
    final image = json['image'];
    return PokeListPart(name: name, id: id, image: image);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
