import 'package:dio/dio.dart';

class BaseUrl {
  static String baseUrl = "http://api.themoviedb.org/3/";
  static String apiKey = "4d560f483fdb51909f54bc37635d7a2c";
  static final BaseOptions _baseOptions =
      BaseOptions(baseUrl: baseUrl, connectTimeout: 5000, receiveTimeout: 3000);
  Dio dio = new Dio(_baseOptions);
}
