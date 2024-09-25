class ServerException implements Exception {
  final String massage;

  ServerException(this.massage);

  @override
  String toString() {
    return "$runtimeType ($massage)";
  }
}

class CacheException implements Exception {
  final String massage;

  CacheException(this.massage);

  @override
  String toString() {
    return "$runtimeType ($massage)";
  }
}
