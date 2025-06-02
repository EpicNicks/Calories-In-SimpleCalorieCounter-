class AggregateException implements Exception {
  final List<Exception> innerExceptions;
  final String _message;
  final Exception? cause;

  AggregateException(this._message, List<Exception> exceptions, [this.cause])
      : innerExceptions = List.unmodifiable(exceptions);

  @override
  String toString() {
    final buffer = StringBuffer();
    buffer.writeln(_message);
    buffer.writeln('Inner Exceptions:');

    for (int i = 0; i < innerExceptions.length; i++) {
      final ex = innerExceptions[i];
      buffer.writeln('  ${i + 1}. ${ex.runtimeType}: ${ex.toString()}');
    }

    return buffer.toString().trimRight();
  }

  void printStackTrace() {
    print(toString());

    for (int i = 0; i < innerExceptions.length; i++) {
      print('Inner Exception #${i + 1}:');
      print(innerExceptions[i]);
    }
  }
}
