import 'dart:io';

import 'package:http/http.dart';

import '../extensions/extensions.dart';

abstract interface class ControllerException {
  Type get source;
  String get title;
  String get message;
}

class ApiServerErrorException extends ControllerException {
  final String? innerMessage;
  final Type innerSource;

  ApiServerErrorException({this.innerMessage, required this.innerSource});

  @override
  String get message => innerMessage ?? "There was a server error. Try again later.";

  @override
  Type get source => innerSource;

  @override
  String get title => "Server Error";
}

class ApiBadRequestException extends ControllerException {
  final String Function(Map<String, dynamic> json)? getMessage;
  final Type innerSource;
  final Response response;

  ApiBadRequestException({required this.getMessage, required this.innerSource, required this.response});

  @override
  String get message {
    var defaultMessage = 'Bad request, check your inputs and try again';
    if (getMessage == null) return defaultMessage;
    try {
      return getMessage!(response.body.toDecodedJson);
    } on FormatException {
      return defaultMessage;
    }
  }

  @override
  Type get source => innerSource;

  @override
  String get title => 'Bad Request';
}

class ApiSocketException extends SocketException implements ControllerException {
  final Type innerSource;
  ApiSocketException(this.innerSource)
      : super(
            "It seems that your device is not connected to the internet or the server is not active. Check your internet connection and try again or try again later.");

  @override
  Type get source => innerSource;

  @override
  String get title => 'Connection Error';
}

class ApiTimeoutException extends ControllerException {
  final Type innerSource;

  ApiTimeoutException(this.innerSource);
  @override
  String get message => 'It seems that your request to the sever timed out, please try again.';

  @override
  Type get source => innerSource;

  @override
  String get title => 'Timeout Error';
}

class ApiEntityNotFoundException extends ControllerException {
  final String? innerMessage;
  final Type innerSource;

  ApiEntityNotFoundException({this.innerMessage, required this.innerSource});
  @override
  String get message => innerMessage ?? 'The item you requested does not exist';

  @override
  Type get source => throw UnimplementedError();

  @override
  String get title => 'Item not found';
}

class ApiAuthorizationException extends ControllerException {
  final Type innerSource;

  ApiAuthorizationException(this.innerSource);
  @override
  String get message => 'You are not authorized to access the resources you requested.';

  @override
  Type get source => innerSource;

  @override
  String get title => 'Authorization Error';
}
