import 'package:dartz/dartz.dart';
import 'package:tuner_app/domain/entities/failure.dart';
import 'package:tuner_app/domain/entities/theme_entity.dart';
import 'package:tuner_app/domain/repositories/theme_repository.dart';
import 'package:tuner_app/domain/usecase/usecase.dart';

class SaveThemeUsecase implements UseCase<ThemeEntity, void> {
  final ThemeRepository repo;

  SaveThemeUsecase({required this.repo});

  @override
  Future<Either<Failure, void>> call(ThemeEntity params) {
    return repo.saveTheme(params);
  }

}