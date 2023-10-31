import 'package:bloc/bloc.dart';
import 'package:dummy_app_with_bloc/src/features/authentication/domain/usecases/create_user.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/get_users.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({
    required this.createUserUseCase,
    required this.getUsersUseCase,
  }) : super(AuthenticationInitial());

  final CreateUser createUserUseCase;
  final GetUsers getUsersUseCase;

  Future<void> createUser({
    required String name,
    required String avatar,
  }) async {
    emit(const CreatingUser());

    final result = await createUserUseCase(
      CreateUserParams(
        name: name,
        avatar: avatar,
      ),
    );

    result.fold(
      (failure) => emit(AuthenticationError(failure.errorMessage)),
      (_) => emit(const UserCreated()),
    );
  }

  Future<void> getUsers() async {
    emit(const GettingUsers());

    final result = await getUsersUseCase();

    result.fold(
      (failure) => emit(AuthenticationError(failure.errorMessage)),
      (users) => emit(UsersLoaded(users)),
    );
  }
}
