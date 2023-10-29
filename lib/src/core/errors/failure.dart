// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dummy_app_with_bloc/src/core/errors/exceptions.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({required this.message, required this.statusCode});

  final String message;
  final int statusCode;

  @override
  List<Object> get props => [message, statusCode];
}

class APIFailure extends Failure {
  const APIFailure({required super.message, required super.statusCode});

  APIFailure.fromExeption(APIException exception)
      : this(message: exception.message, statusCode: exception.statusCode);
}
