import 'package:dummy_app_with_bloc/src/core/utils/typedef.dart';

abstract class UsecaseWithParams<T, Params> {
  ResultFuture<T> call(Params params);
}

abstract class UsecaseWitoutParams<T> {
  ResultFuture<T> call();
}
