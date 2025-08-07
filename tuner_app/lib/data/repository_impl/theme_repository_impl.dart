import 'package:dartz/dartz.dart';
import 'package:tuner_app/data/shared_preferences/preferences_datasource.dart';
import 'package:tuner_app/domain/entities/failure.dart';
import 'package:tuner_app/domain/entities/theme_entity.dart';
import 'package:tuner_app/domain/repositories/theme_repository.dart';

class ThemeRepositoryImpl implements ThemeRepository {

  final PreferencesDatasource datasource;

  ThemeRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, ThemeEntity>> getTheme() async {
    return await datasource.getTheme(); 
  }

  @override
  Future<Either<Failure, void>> saveTheme(ThemeEntity theme) async {
    return await datasource.saveTheme(theme);
  }

}