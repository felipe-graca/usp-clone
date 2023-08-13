import 'dart:convert';

class UserModel {
  final String name;
  final String base64Image;
  final String faculdade;
  final String typeCurse;
  final String dueDate;
  final String id;

  UserModel({
    this.name = '',
    this.base64Image = '',
    this.faculdade = '',
    this.typeCurse = '',
    this.dueDate = '',
    this.id = '',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'base64Image': base64Image,
      'faculdade': faculdade,
      'typeCurse': typeCurse,
      'dueDate': dueDate,
      'id': id,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      base64Image: map['base64Image'] as String,
      faculdade: map['faculdade'] as String,
      typeCurse: map['typeCurse'] as String,
      dueDate: map['dueDate'] as String,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserModel copyWith({
    String? name,
    String? base64Image,
    String? faculdade,
    String? typeCurse,
    String? dueDate,
    String? id,
  }) {
    return UserModel(
      name: name ?? this.name,
      base64Image: base64Image ?? this.base64Image,
      faculdade: faculdade ?? this.faculdade,
      typeCurse: typeCurse ?? this.typeCurse,
      dueDate: dueDate ?? this.dueDate,
      id: id ?? this.id,
    );
  }
}
