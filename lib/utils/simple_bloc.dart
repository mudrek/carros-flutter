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

  void addError(error) {
    if (!_streamController.isClosed) {
      _streamController.addError(error);
    }
  }
}
