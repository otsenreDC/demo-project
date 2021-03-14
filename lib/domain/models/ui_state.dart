import 'package:flutter/cupertino.dart';

abstract class UIState {}

class UILoading implements UIState {}

class UIError implements UIState {
  Exception exception;
  String message;

  UIError({
    @required this.message,
    this.exception,
  });
}

class UIShowData<T> implements UIState {
  T data;

  UIShowData({this.data});
}
