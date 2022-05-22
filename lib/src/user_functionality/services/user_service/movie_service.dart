
import 'package:mvvm_demo/src/user_functionality/business_logic/models/movie_model.dart';

abstract class MovieService {
  Future<List<Result>> getDiscoverMovie();
}

