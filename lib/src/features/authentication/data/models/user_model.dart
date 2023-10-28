import 'dart:convert';

import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.avatar,
  });

  UserModel copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
    String? avatar,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      avatar: avatar ?? this.avatar,
    );
  }

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source));

  String toJson() => jsonEncode(toMap());

  UserModel.fromMap(Map<String, dynamic> map)
      : this(
          id: map['id'],
          name: map['name'],
          createdAt: DateTime.tryParse(map['createdAt'])!,
          avatar: map['avatar'],
        );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'createdAt': createdAt.toString(),
        'avatar': avatar,
      };

  UserModel.empty()
      : this(
          id: 'id',
          name: 'name',
          createdAt: DateTime.now(),
          avatar: 'avatar',
        );
}
