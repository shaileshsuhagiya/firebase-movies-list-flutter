import 'package:dartz/dartz.dart';
import 'package:mvvm_demo/src/movie_functionality/business_logic/enums/view_state.dart';
import 'package:mvvm_demo/src/movie_functionality/business_logic/models/base_model.dart';
import 'package:mvvm_demo/src/movie_functionality/business_logic/models/failure.dart';
import 'package:mvvm_demo/src/movie_functionality/business_logic/models/movie_model.dart';
import 'package:mvvm_demo/src/movie_functionality/business_logic/utils/map_letft_to_faliure.dart';
import 'package:mvvm_demo/src/movie_functionality/services/dependency_assembler_education.dart';
import 'package:mvvm_demo/src/movie_functionality/services/user_service/movie_service.dart';

class MovieViewModel extends BaseModel {
  final MovieService _userRepository =
  dependencyAssembler<MovieService>();

  Either<Failure, List<Result>>? _movieList;

  ///Handle Error and Result using Datrz
  Either<Failure, List<Result>>? get movieList => _movieList;

  Future<void>  getMovieData()  async {
    updateState(ViewState.Busy);
    await Task(() => _userRepository.getDiscoverMovie())
        .attempt()
        .mapLeftToFailure()
        .run()
        .then((data) =>
    _movieList = data as Either<Failure, List<Result>>?);
    updateState(ViewState.Idle);
  }

}
