import 'package:dartz/dartz.dart';
import 'package:tuner_app/domain/entities/failure.dart';
import 'package:tuner_app/domain/entities/theme_entity.dart';

abstract class ThemeRepository {
  Future<Either<Failure, ThemeEntity>> getTheme();

  Future<Either<Failure, void>> saveTheme(ThemeEntity theme);
}