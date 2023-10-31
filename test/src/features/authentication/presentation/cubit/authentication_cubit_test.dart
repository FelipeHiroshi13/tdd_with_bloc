import 'package:dummy_app_with_bloc/src/features/authentication/domain/usecases/create_user.dart';
import 'package:dummy_app_with_bloc/src/features/authentication/domain/usecases/get_users.dart';
import 'package:dummy_app_with_bloc/src/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetUser extends Mock implements GetUsers {}

class MockCreateUser extends Mock implements CreateUser {}

void main() {
  late GetUsers getUsers;
  late CreateUser createUser;
  late AuthenticationCubit cubit;

  setUp(() {
    getUsers = MockGetUser();
    createUser = MockCreateUser();
    cubit = AuthenticationCubit(
        createUserUseCase: createUser, getUsersUseCase: getUsers);
  });

  tearDown(() => cubit.close());

  test('Initial state should be [AuthenticationInitial]', () async {
    expect(cubit.state, const AuthenticationInitial());
  });
}
