class _TodoException implements Exception {
  final String message;

  const _TodoException(this.message);

  @override
  String toString() {
    return 'Todo: $message';
  }
}

// ignore: non_constant_identifier_names
Never TODO([String message = 'You hit a TODO!']) {
  throw _TodoException(message);
}
