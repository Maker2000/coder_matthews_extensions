class AppException implements Exception {
  final String title, message;
  final void Function()? callback;
  AppException(this.title, this.message, [this.callback]);
}
