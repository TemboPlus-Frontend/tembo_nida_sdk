import 'package:flutter/material.dart';

class Manager<T> extends ValueNotifier<T> {
  Manager(super.data);

  void update(T data) {
    value = data;
    notifyListeners();
  }
}