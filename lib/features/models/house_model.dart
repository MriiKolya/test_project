import 'dart:convert';

class HouseModel {
  final int id;
  final String name;
  final int floor;
  final List<bool> listFloor;

  @override
  String toString() => 'id: $id; name: $name; floor: $floor';

  HouseModel({
    required this.id,
    required this.name,
    required this.floor,
    required this.listFloor,
  });

  factory HouseModel.fromSqflite(Map<String, dynamic> map) {
    List<dynamic> jsonList = map['vacantApartments'] != null
        ? jsonDecode(map['vacantApartments'])
        : [];

    List<bool> boolList = jsonList.map((e) => e as bool).toList();

    return HouseModel(
      id: map['id'] as int,
      name: map['name'] as String? ?? '',
      floor: map['floor'] as int? ?? 0,
      listFloor: boolList,
    );
  }
}
