import 'package:dartz/dartz.dart';
import 'package:mvvm_demo/src/user_functionality/business_logic/models/failure.dart';

extension TaskX<T extends Either<Object, U>, U> on Task<T> {
  Task<Either<Failure, U>> mapLeftToFailure() {
    return this.map((either) => either.leftMap((obj) {
          try {
            return obj as Failure;
          } catch (e) {
            throw obj;
          }
        }));
  }
}
