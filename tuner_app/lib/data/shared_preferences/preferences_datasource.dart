import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuner_app/domain/entities/failure.dart';
import 'package:tuner_app/domain/entities/theme_entity.dart';
import 'package:tuner_app/domain/params/no_params.dart';

class PreferencesDatasource {
  final SharedPreferences preferences;

  PreferencesDatasource({required this.preferences});

  Future<Either<Failure, void>> saveTheme(ThemeEntity theme) async {
    try {
      var themeValue = theme.theme == ThemeType.dark ? 'dark' : 'light';
      await preferences.setString('theme_key', themeValue);  
      print(preferences.getString('theme_key'));
      return Right(NoParams());
    }
    catch(e){
      return left(DataSourceException('message'));
    }
  }

  Future<Either<Failure, ThemeEntity>> getTheme() async {
    try {
      var themeValue = preferences.getString('theme_key');
      if(themeValue == 'dark') {
        return Right(ThemeEntity(theme: ThemeType.dark));
      }
      else{
        return Right(ThemeEntity(theme: ThemeType.light));
      }
    }
    catch(e){
      return left(DataSourceException('message'));
    }
  } 
}