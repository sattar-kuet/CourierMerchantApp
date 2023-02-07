class Upazilla {
  int id = 0;
  String name = '';

  Upazilla(this.id, this.name);
  Upazilla.fromJson(Map<String, dynamic> UpazillaMap) {
    id = UpazillaMap['id'] ?? 0;
    name = UpazillaMap['name'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
