

import 'package:get_it/get_it.dart';
import 'package:mvvm_demo/src/movie_functionality/business_logic/view_models/user_view_model.dart';
import 'package:mvvm_demo/src/movie_functionality/services/user_service/movie_service.dart';
import 'package:mvvm_demo/src/movie_functionality/services/user_service/movie_service_implementation.dart';
import 'package:mvvm_demo/src/movie_functionality/services/web_verbs/api_base_helper.dart';
import 'package:mvvm_demo/src/movie_functionality/services/web_verbs/api_base_helper_implementaion.dart';

GetIt dependencyAssembler = GetIt.instance;

Future<void> setupDependencyAssemblerEducation() async {
  //Services
  dependencyAssembler
      .registerFactory<ApiBaseHelper>(() => ApiBaseHelperImplementation());
  dependencyAssembler
      .registerFactory<MovieViewModel>(() => MovieViewModel());
  dependencyAssembler
      .registerFactory<MovieService>(() => MovieServiceImplementation());

}
