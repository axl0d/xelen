import 'package:dartz/dartz.dart';

abstract class Failure {}

mixin ResultHandler {
  Future<Either<Failure, R>> handlerFutureEither<Failure, R>(
    Future<R> Function() request,
    Failure Function(dynamic err) failure,
  ) async {
    try {
      final response = await request();
      return Right(response);
    } catch (e) {
      return Left(failure(e));
    }
  }

  Future<R?> handlerFuture<R>(
    Future<R> Function() request,
    Failure Function(dynamic err) failure,
  ) async {
    final either = await handlerFutureEither(request, failure);
    final result = either.fold((_) => null, (r) => r);
    return result;
  }

  Either<Failure, R> handlerEither<Failure, R>(
    R Function() callback,
    Failure Function(dynamic err) failure,
  ) {
    try {
      return Right(callback());
    } catch (e) {
      return Left(failure(e));
    }
  }

  R? handler<R>(
    R Function() request,
    Failure Function(dynamic err) failure,
  ) {
    final either = handlerEither(request, failure);
    final result = either.fold((_) => null, (r) => r);
    return result;
  }

  Future<Either<Failure, M>> handlerEitherService<R, M>({
    required Future<R> Function() request,
    required Failure Function(dynamic err) requestFailure,
    required M Function(R response) parser,
    required Failure Function(dynamic err) parserFailure,
  }) async {
    final eitherRequest = await handlerFutureEither(request, requestFailure);

    final responseOrFailureRequest = eitherRequest.fold((l) => l, (r) => r);
    if (responseOrFailureRequest is Failure) {
      return Left(requestFailure(responseOrFailureRequest));
    }
    final resultRequest = responseOrFailureRequest as R;

    final eitherCast = handlerEither(
      () => parser(resultRequest),
      parserFailure,
    );
    final resultOrFailCast = eitherCast.fold((l) => l, (r) => r);
    if (resultOrFailCast is Failure) {
      return Left(parserFailure(resultOrFailCast));
    }
    final result = resultOrFailCast as M;

    return Right(result);
  }

  Future<M?> handlerService<R, M>({
    required Future<R> Function() request,
    required Failure Function(dynamic err) onRequestFailure,
    required M Function(R response) parser,
    required Failure Function(dynamic err) onParserFailure,
  }) async {
    final eitherRequest = await handlerFutureEither(request, onRequestFailure);

    final responseOrFailureRequest = eitherRequest.fold((l) => l, (r) => r);
    if (responseOrFailureRequest is Failure) return null;
    final resultRequest = responseOrFailureRequest as R;

    final eitherCast = handlerEither(
      () => parser(resultRequest),
      onParserFailure,
    );
    final resultOrFailCast = eitherCast.fold((l) => l, (r) => r);
    if (resultOrFailCast is Failure) return null;
    final result = resultOrFailCast as M;

    return result;
  }
}
