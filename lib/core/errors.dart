/// A failure the user can read. [message] is the whole explanation.
class InvoxaException implements Exception {
  InvoxaException(this.message);

  final String message;

  @override
  String toString() => message;
}
