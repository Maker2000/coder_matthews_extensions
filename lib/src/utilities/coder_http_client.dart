import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:coder_matthews_extensions/src/utilities/type_definitions.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../exceptions/controller_exception.dart';
import 'multipart_request_with_progress.dart';

/// A custom [HttpClient] client that throws exceptions rather than return just a response.
///
/// Use [handleResponse] to return a nullable exception should the response status code is not 200. Setting this to null will not throw any exceptions.
///
/// Check out the factory methods [createDefault] and [createDefaultWithHandleResponse]
class CoderHttpClient {
  late Client innerClient;
  final Future<Map<String, String>> Function()? baseHeaders;
  final ControllerException? Function(Response response, Type source)? handleResponse;
  final ControllerException Function(String errorMessage, Type source) socketException;
  final ControllerException Function(Type source) timeoutException;
  CoderHttpClient(
      {required this.socketException,
      required this.timeoutException,
      this.handleResponse,
      required this.baseHeaders,
      Client? innerClient}) {
    this.innerClient = innerClient ?? Client();
  }

  /// Creates a default [CoderHttpClient] that sets the [socketException] and [timeoutException] properties to a [ApiSocketException] and [ApiTimeoutException] respectively.
  factory CoderHttpClient.createDefault({
    ControllerException? Function(Response response, Type source)? handleResponse,
    Future<Map<String, String>> Function()? baseHeaders,
    Client? innerClient,
  }) =>
      CoderHttpClient(
        socketException: (message, source) => ApiSocketException(source),
        timeoutException: (source) => ApiTimeoutException(source),
        baseHeaders: baseHeaders,
        handleResponse: handleResponse,
        innerClient: innerClient,
      );

  /// Does the same as [CoderHttpClient.createDefault] but also adds the use of the [defaultHandleResponse] that handles the response codes 400, 404 and 500.
  factory CoderHttpClient.createDefaultWithHandleResponse({
    Future<Map<String, String>> Function()? baseHeaders,
    Client? innerClient,
    required String Function(Map<String, dynamic> json) get400Message,
  }) =>
      CoderHttpClient(
        socketException: (message, source) => ApiSocketException(source),
        timeoutException: (source) => ApiTimeoutException(source),
        baseHeaders: baseHeaders,
        handleResponse: (response, source) => defaultHandleResponse(response, source, get400Message),
        innerClient: innerClient,
      );

  /// This [defaultHandleResponse] function only handles the status codes: 400, 401 and 500
  static ControllerException? defaultHandleResponse(Response response, Type source,
      [String Function(Map<String, dynamic> json)? get400Message]) {
    switch (response.statusCode) {
      case (400):
        return ApiBadRequestException(getMessage: get400Message, innerSource: source, response: response);
      case (404):
        return ApiEntityNotFoundException(innerSource: source);
      case (401):
        return ApiAuthorizationException(source);
      case 500:
        return ApiServerErrorException(innerSource: source);
      default:
        return null;
    }
  }

  Future<Map<String, String>> getHeaders(Map<String, String>? headers) async {
    var newHeaders = await baseHeaders?.call() ?? {};
    if (headers != null) {
      newHeaders.addAll(headers);
      //   newHeaders.addAll({HttpHeaders.contentTypeHeader: ContentType.json.value});
    }
    return newHeaders;
  }

  /// Allows for uploading a file using HTTP POST. Accepts an [onProgress] callback function to show progress
  Future<void> upload<TSource>(
    Uri url, {
    required List<MultipartFile> files,
    OnProgress? onProgress,
    Map<String, String>? headers,
  }) async {
    var request = MultiPartRequestWithProgress("POST", url, onProgress: onProgress);
    request.files.addAll(files);
    if (headers != null) request.headers.addAll(headers);
    request.headers.addAll(await baseHeaders?.call() ?? {});
    await send<TSource>(request);
  }

  /// Static function that downloads a from a url and saves the file to the file path provided if setting up a [CoderHttpClient] isn't needed.
  static Future<File?> downloadFile(Uri url,
      {required String saveFilePath,
      void Function(Object error)? onError,
      OnProgress? onProgress,
      Map<String, String>? headers}) async {
    try {
      var downloadClient = Client();
      var request = MultiPartRequestWithProgress("GET", url, onProgress: onProgress);
      if (headers != null) request.headers.addAll(headers);
      final res = await Response.fromStream(await downloadClient.send(request));
      final file = File(saveFilePath);
      await file.writeAsBytes(res.bodyBytes);
      downloadClient.close();
      return file;
    } catch (e) {
      if (onError != null) {
        onError(e);
        return null;
      } else {
        rethrow;
      }
    }
  }

  /// Downloads a from a url and saves the file to the file path provided.
  Future<File> download<TSource>(
    Uri url, {
    required String saveFilePath,
    OnProgress? onProgress,
    Map<String, String>? headers,
  }) async {
    var request = MultiPartRequestWithProgress("GET", url, onProgress: onProgress);
    if (headers != null) request.headers.addAll(headers);
    request.headers.addAll(await baseHeaders?.call() ?? {});
    final res = await Response.fromStream(await send<TSource>(request));
    final file = File(saveFilePath);
    await file.writeAsBytes(res.bodyBytes);
    return file;
  }

  /// Wrapper function that sends an HTTP request and asynchronously returns the response.
  Future<StreamedResponse> send<TSource>(BaseRequest request) async {
    var res = await _tryRequest<TSource, StreamedResponse>(() => innerClient.send(request));
    _handleResponse<TSource>(await Response.fromStream(res));
    return res;
  }

  /// Wrapper function that sends an HTTP GET request with the given headers to the given URL.
  ///
  /// For more fine-grained control over the request, use [send] instead.
  ///
  /// Throws an exception defined in [handleResponse] should the response status code not be 200
  Future<Response> get<TSource>(Uri uri, {Map<String, String>? headers}) {
    return _executeRequest<TSource>(() async => await innerClient.get(uri, headers: await getHeaders(headers)));
  }

  /// Wrapper function that sends an HTTP POST request with the given headers and body to the given
  /// URL.
  ///
  /// [body] sets the body of the request. It can be a [String], a [List<int>]
  /// or a [Map<String, String>].
  ///
  /// If [body] is a String, it's encoded using [encoding] and used as the body
  /// of the request. The content-type of the request will default to
  /// "text/plain".
  ///
  /// If [body] is a List, it's used as a list of bytes for the body of the
  /// request.
  ///
  /// If [body] is a Map, it's encoded as form fields using [encoding]. The
  /// content-type of the request will be set to
  /// `"application/x-www-form-urlencoded"`; this cannot be overridden.
  ///
  /// [encoding] defaults to [utf8].
  ///
  /// For more fine-grained control over the request, use [send] instead.
  ///
  /// Throws an exception defined in [handleResponse] should the response status code not be 200
  Future<Response> post<TSource>(Uri uri, {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    return _executeRequest<TSource>(
        () async => await innerClient.post(uri, headers: await getHeaders(headers), body: body, encoding: encoding));
  }

  /// Wrapper function that sends an HTTP PUT request with the given headers and body to the given
  /// URL.
  ///
  /// [body] sets the body of the request. It can be a [String], a [List<int>]
  /// or a [Map<String, String>]. If it's a String, it's encoded using
  /// [encoding] and used as the body of the request. The content-type of the
  /// request will default to "text/plain".
  ///
  /// If [body] is a List, it's used as a list of bytes for the body of the
  /// request.
  ///
  /// If [body] is a Map, it's encoded as form fields using [encoding]. The
  /// content-type of the request will be set to
  /// `"application/x-www-form-urlencoded"`; this cannot be overridden.
  ///
  /// [encoding] defaults to [utf8].
  ///
  /// For more fine-grained control over the request, use [send] instead.
  ///
  /// Throws an exception defined in [handleResponse] should the response status code not be 200
  Future<Response> put<TSource>(Uri uri, {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    return _executeRequest<TSource>(
        () async => await innerClient.put(uri, headers: await getHeaders(headers), body: body, encoding: encoding));
  }

  /// Wrapper function that sends an HTTP DELETE request with the given headers to the given URL.
  ///
  /// For more fine-grained control over the request, use [send] instead.
  ///
  /// Throws an exception defined in [handleResponse] should the response status code not be 200
  Future<Response> delete<TSource>(Uri uri, {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    return _executeRequest<TSource>(
        () async => await innerClient.delete(uri, headers: await getHeaders(headers), body: body, encoding: encoding));
  }

  /// Wrapper function that sends an HTTP PATCH request with the given headers and body to the given
  /// URL.
  ///
  /// [body] sets the body of the request. It can be a [String], a [List<int>]
  /// or a [Map<String, String>]. If it's a String, it's encoded using
  /// [encoding] and used as the body of the request. The content-type of the
  /// request will default to "text/plain".
  ///
  /// If [body] is a List, it's used as a list of bytes for the body of the
  /// request.
  ///
  /// If [body] is a Map, it's encoded as form fields using [encoding]. The
  /// content-type of the request will be set to
  /// `"application/x-www-form-urlencoded"`; this cannot be overridden.
  ///
  /// [encoding] defaults to [utf8].
  ///
  /// For more fine-grained control over the request, use [send] instead.
  ///
  /// Throws an exception defined in [handleResponse] should the response status code not be 200
  Future<Response> patch<TSource>(Uri uri, {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    return _executeRequest<TSource>(
        () async => await innerClient.patch(uri, headers: await getHeaders(headers), body: body, encoding: encoding));
  }

  /// Wrapper function that sends an HTTP HEAD request with the given headers to the given URL.
  ///
  /// For more fine-grained control over the request, use [send] instead.
  ///
  /// Throws an exception defined in [handleResponse] should the response status code not be 200
  Future<Response> head<TSource>(Uri uri, {Map<String, String>? headers}) {
    return _executeRequest<TSource>(() async => await innerClient.head(uri, headers: await getHeaders(headers)));
  }

  /// Wrapper function that sends an HTTP GET request with the given headers to the given URL and
  /// returns a Future that completes to the body of the response as a String.
  ///
  /// The Future will emit a [ClientException] if the response doesn't have a
  /// success status code.
  ///
  /// For more fine-grained control over the request and response, use [send] or
  /// [get] instead.
  Future<String> read<TSource>(Uri uri, {Map<String, String>? headers}) {
    return _tryRequest<TSource, String>(() async => await innerClient.read(uri, headers: await getHeaders(headers)));
  }

  /// Wrapper function that sends an HTTP GET request with the given headers to the given URL and
  /// returns a Future that completes to the body of the response as a list of
  /// bytes.
  ///
  /// The Future will emit a [ClientException] if the response doesn't have a
  /// success status code.
  ///
  /// For more fine-grained control over the request and response, use [send] or
  /// [get] instead.
  Future<Uint8List> readBytes<TSource>(Uri uri, {Map<String, String>? headers}) {
    return _tryRequest<TSource, Uint8List>(() async => innerClient.readBytes(uri, headers: await getHeaders(headers)));
  }

  /// Closes the client and cleans up any resources associated with it.
  ///
  /// It's important to close each client when it's done being used; failing to
  /// do so can cause the Dart process to hang.
  ///
  /// Once [close] is called, no other methods should be called. If [close] is
  /// called while other asynchronous methods are running, the behavior is
  /// undefined.
  void close<TSource>() {
    return innerClient.close();
  }

  Future<Response> _executeRequest<TSource>(Future<Response> Function() op) async {
    var res = await _tryRequest<TSource, Response>(op);
    _handleResponse(res);
    return res;
  }

  void _handleResponse<TSource>(Response response) {
    if (handleResponse != null) {
      var exception = handleResponse!(response, TSource);
      if (exception != null) throw exception;
    }
  }

  Future<TResponse> _tryRequest<TSource, TResponse>(Future<TResponse> Function() op) async {
    try {
      return await op();
    } on SocketException catch (e) {
      throw socketException(e.message, TSource);
    } on TimeoutException {
      throw timeoutException(TSource);
    }
  }
}
