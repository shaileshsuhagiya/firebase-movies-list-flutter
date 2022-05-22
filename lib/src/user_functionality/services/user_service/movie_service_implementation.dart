import 'package:mvvm_demo/src/user_functionality/services/dependency_assembler_education.dart';
import 'package:mvvm_demo/src/user_functionality/services/web_verbs/api_base_helper.dart';
import 'package:mvvm_demo/src/configs/app_configurations.dart';
import 'package:mvvm_demo/src/user_functionality/business_logic/models/failure.dart';
import 'package:mvvm_demo/src/user_functionality/business_logic/models/movie_model.dart';
import 'package:mvvm_demo/src/user_functionality/business_logic/utils/exception_utility.dart';
import 'package:mvvm_demo/src/user_functionality/services/user_service/movie_service.dart';


class MovieServiceImplementation extends MovieService{
  final ApiBaseHelper _apiBaseHelper = dependencyAssembler<ApiBaseHelper>();

  @override
  Future<List<Result>> getDiscoverMovie()async {
    try {
      final response = await _apiBaseHelper.get(
          url: Config.discoverMovie);
      print("data is ${response}");
      List<MovieModel> userList = [];
      MovieModel userDetailsModel = MovieModel.fromJson(response);

      return userDetailsModel.results!;
    } on Failure catch (failure) {
      throw failure;
    } catch (e) {
      throw getCurrentFailure(e);
    }
  }

}