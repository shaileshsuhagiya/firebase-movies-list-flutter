import 'package:flutter/material.dart';
import 'package:mvvm_demo/src/movie_functionality/business_logic/models/movie_model.dart';
import 'package:provider/provider.dart';
import 'package:mvvm_demo/src/movie_functionality/business_logic/enums/view_state.dart';
import 'package:mvvm_demo/src/movie_functionality/business_logic/view_models/user_view_model.dart';
import 'package:mvvm_demo/src/movie_functionality/services/dependency_assembler_education.dart';
import 'package:mvvm_demo/src/movie_functionality/ui/shared/no_internet_connection_scaffold.dart';
import '../widgets/movie_tile.dart';

class MovieScreen extends StatefulWidget {
  static const String routeName = '/userDetailsScreen';

  const MovieScreen({Key? key}) : super(key: key);
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {

  final MovieViewModel _movieViewModel = dependencyAssembler<MovieViewModel>();

  @override
  void initState() {
    getUser();
    super.initState();
  }

  Future<void> getUser() async {
    _movieViewModel.getMovieData();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MovieViewModel>.value(
      value: _movieViewModel,
      child: Consumer<MovieViewModel>(
        builder: (BuildContext context, MovieViewModel model, Widget? child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar:AppBar(title: const Text("Popular Moview")) ,
            body: _movieViewModel.state == ViewState.Busy
                ? const Center(child: CircularProgressIndicator())
                : Center(
                    child: _movieViewModel.movieList!.fold((failure) {
                      return NoInternetConnectionScaffold(
                        failure: failure,
                        onTryAgain: getUser,
                      );
                    }, (movie) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: movie.length,
                        itemBuilder: (context, index) {
                          Result data = movie[index];
                          return movieListTile(data);
                        },
                      );
                    }),
                  ),
          );
        },
      ),
    );
  }
}
