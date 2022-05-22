class Failure {
  final String? errorMessage;
  final dynamic error;
  final bool requireConfirmation;

  Failure({this.error, this.errorMessage, this.requireConfirmation = false});

  @override
  String toString() {
    return errorMessage!;
  }
}
