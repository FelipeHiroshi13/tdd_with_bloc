import 'package:dartz/dartz.dart';
import 'package:dummy_app_with_bloc/src/core/errors/failure.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
