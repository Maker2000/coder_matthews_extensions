extension StringExtn on String? {
  ///Returns a bool whether string value is null or empty
  bool get isNullOrEmpty {
    if (this == null) return true;
    return this!.isEmpty;
  }

  /// Returns a bool value whether string value is not null or empty
  bool get isNotNullOrEmpty {
    if (this == null) return false;
    return this!.isNotEmpty;
  }
}
