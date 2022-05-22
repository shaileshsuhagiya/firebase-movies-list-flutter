
import 'package:mvvm_demo/src/movie_functionality/business_logic/models/movie_model.dart';

abstract class MovieService {
  Future<List<Result>> getDiscoverMovie();
}

