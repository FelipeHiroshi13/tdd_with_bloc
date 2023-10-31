part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class CreateUserEvent extends AuthenticationEvent {
  const CreateUserEvent({required this.name, required this.avatar});
  final String name;
  final String avatar;

  @override
  List<Object> get props => [name, avatar];
}

class GetUsersEvent extends AuthenticationEvent {
  const GetUsersEvent();
}
