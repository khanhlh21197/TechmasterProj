import 'dart:async';

class TextBloc {
  int number = 0;

  TextBloc() {
    init();
  }

  StreamController _streamController = StreamController<int>.broadcast();
  StreamSink<int> get sink => _streamController.sink;
  Stream<int> get stream => _streamController.stream;

  void increase() {
    number++;
    sink.add(number);
    // _streamController.add(number);
  }

  void decrease() {
    number--;
    sink.add(number);
    // _streamController.add(number);
  }

  void init() {
    sink.add(number);
    // _streamController.add(number);
  }

  void dispose() {
    _streamController.close();
  }
}
