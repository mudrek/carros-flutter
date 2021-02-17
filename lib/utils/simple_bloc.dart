import 'dart:async';

class SimpleBloc<T> {

  final _streamController = StreamController<T>();

  get stream => _streamController.stream;

  void add(Object object) {
    _streamController.add(object);
  }

  void dispose() {
    _streamController.close();
  }

  void addError(Error error) {
    _streamController.addError(error);
  }
}