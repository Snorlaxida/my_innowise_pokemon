class PokeListPart {
  final String name;
  final int id;

  PokeListPart({required this.name, required this.id});

  factory PokeListPart.fromJson(Map<String, dynamic> json) {
    final name = json['name'];
    final id = int.parse(json['url'].toString().split('/')[6]);
    return PokeListPart(name: name, id: id);
  }

  factory PokeListPart.fromDbJson(Map<String, dynamic> json) {
    final name = json['name'];
    final id = json['id'];
    return PokeListPart(name: name, id: id);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
