import 'package:dartz/dartz.dart';
import 'package:tuner_app/domain/entities/failure.dart';
import 'package:tuner_app/domain/entities/theme_entity.dart';
import 'package:tuner_app/domain/repositories/theme_repository.dart';
import 'package:tuner_app/domain/usecase/usecase.dart';

class GetThemeUsecase implements UseCase<void, ThemeEntity> {
  final ThemeRepository repo;

  GetThemeUsecase({required this.repo});

  @override
  Future<Either<Failure, ThemeEntity>> call(params) {
    return repo.getTheme();
  }
}