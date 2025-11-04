abstract class ApiResults<T> {}

class ApiSuccess<T>  extends ApiResults<T>{
  final T? data;

  ApiSuccess({  this.data});
}

class ApiFailure<T> extends ApiResults<T> {
  final String message;

  ApiFailure(this.message);
}
