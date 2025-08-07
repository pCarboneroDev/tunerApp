import 'package:dartz/dartz.dart';
import 'package:tuner_app/domain/entities/failure.dart';

abstract class UseCase<Input, Output> {
  Future<Either<Failure, Output>> call(Input params);
}