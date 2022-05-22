

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mvvm_demo/src/constant/lottile_paths.dart';
import 'package:mvvm_demo/src/movie_functionality/business_logic/models/failure.dart';

class ServiceError extends StatefulWidget {
  final Function? onTryAgain;
  final Failure? failure;
  String? errorMessage = "No Internet Connection";
  ServiceError(
      {Key? key, this.onTryAgain,
      this.failure,
      this.errorMessage = "No Internet Connection"}) : super(key: key);

  @override
  _ServiceErrorState createState() => _ServiceErrorState();
}

class _ServiceErrorState extends State<ServiceError> {
  bool _isLoading = false;
  Future<void> onTryAgain() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await widget.onTryAgain!();
    } catch (e) {
      print(e.toString());

      print(widget.errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            LottiePaths.noInternetConnection,
            width: mediaQuery.size.width * .8,
            height: mediaQuery.size.height * .4,
          ),
          const SizedBox(
            height: 4,
          ),
          Padding(
            padding:  const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              widget.errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          _isLoading
              ? const CircularProgressIndicator()
              : TextButton(
                  onPressed: onTryAgain,
                  child: const Text(
                    "Try Again!",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue),
                  ))
        ]);
  }
}
