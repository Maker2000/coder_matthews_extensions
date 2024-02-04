import 'package:http/http.dart';

import '../exceptions/exceptions.dart';

typedef OnProgress = void Function(int current, int total);
typedef OnHttpResponse = ControllerException? Function(Response response, Type source);
