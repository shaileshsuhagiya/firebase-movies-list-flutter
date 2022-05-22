

import 'package:flutter/material.dart';
import 'package:mvvm_demo/src/movie_functionality/business_logic/models/failure.dart';
import 'package:mvvm_demo/src/movie_functionality/ui/shared/service_error.dart';

class NoInternetConnectionScaffold extends StatelessWidget {
  final Function? onTryAgain;
  final Failure? failure;
  String? errorMessage = "No Internet Connection";

  NoInternetConnectionScaffold(
      {Key? key, this.onTryAgain, this.failure, this.errorMessage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: ServiceError(
                failure: failure,
                onTryAgain: () => onTryAgain!(),
                errorMessage:  failure!.errorMessage!,
              ),
            )
          ],
        ),
      ),
    );
  }
}
