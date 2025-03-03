import 'package:dio/dio.dart';

// Wrapper class to determine the state of the response
abstract class DataState<T> {
  final T? data;
  final DioException? error;

  const DataState({this.data, this.error});
}

// Successful response
class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

// Failed Response
class DataFailed<T> extends DataState<T> {
  const DataFailed(DioException error) : super(error: error);
}
