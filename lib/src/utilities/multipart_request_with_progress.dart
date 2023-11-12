import 'dart:async';

import 'type_definitions.dart';
import 'package:http/http.dart';

class MultiPartRequestWithProgress extends MultipartRequest {
  /// Creates a new [MultiPartRequestWithProgress].
  MultiPartRequestWithProgress(
    super.method,
    super.url, {
    this.onProgress,
  });

  final OnProgress? onProgress;

  /// Freezes all mutable fields and returns a single-subscription [ByteStream]
  /// that will emit the request body.
  @override
  ByteStream finalize() {
    final byteStream = super.finalize();
    if (onProgress == null) return byteStream;

    final total = contentLength;
    int bytes = 0;

    final t = StreamTransformer.fromHandlers(
      handleData: (List<int> data, EventSink<List<int>> sink) {
        bytes += data.length;
        onProgress!(bytes, total);
        sink.add(data);
      },
    );
    final stream = byteStream.transform(t);
    return ByteStream(stream);
  }
}
