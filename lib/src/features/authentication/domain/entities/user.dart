import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.avatar,
  });

  final String id;
  final String name;
  final DateTime createdAt;
  final String avatar;

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, createdAt, avatar];
}
