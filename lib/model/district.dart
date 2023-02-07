class District {
  int id = 0;
  String name = '';

  District(this.id, this.name);
  District.fromJson(Map<String, dynamic> districtMap) {
    id = districtMap['id'] ?? 0;
    name = districtMap['name'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
