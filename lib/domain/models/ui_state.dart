abstract class UIState {}

class UILoading implements UIState {}

class UIError<T> implements UIState {
  Exception exception;
  String message;
  T errorData;

  UIError({
    this.message = "",
    this.exception,
    this.errorData,
  });
}

class UIShowData<T> implements UIState {
  T data;

  UIShowData({this.data});
}
