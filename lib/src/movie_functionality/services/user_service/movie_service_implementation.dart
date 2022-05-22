import 'package:mvvm_demo/src/movie_functionality/services/dependency_assembler_education.dart';
import 'package:mvvm_demo/src/movie_functionality/services/web_verbs/api_base_helper.dart';
import 'package:mvvm_demo/src/configs/app_configurations.dart';
import 'package:mvvm_demo/src/movie_functionality/business_logic/models/failure.dart';
import 'package:mvvm_demo/src/movie_functionality/business_logic/models/movie_model.dart';
import 'package:mvvm_demo/src/movie_functionality/business_logic/utils/exception_utility.dart';
import 'package:mvvm_demo/src/movie_functionality/services/user_service/movie_service.dart';


class MovieServiceImplementation extends MovieService{
  final ApiBaseHelper _apiBaseHelper = dependencyAssembler<ApiBaseHelper>();
 /// Here we handle API data and Failure response of the API
  @override
  Future<List<Result>> getDiscoverMovie()async {
    try {
      final response = await _apiBaseHelper.get(
          url: Config.discoverMovie);
      return  MovieModel.fromJson(response).results!;
    } on Failure catch (failure) {
      throw failure;
    } catch (e) {
      throw getCurrentFailure(e);
    }
  }

}