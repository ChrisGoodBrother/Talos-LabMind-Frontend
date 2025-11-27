import 'dart:async';
import 'dart:developer';
import 'dart:convert';
import 'package:dio/dio.dart';

class ServerServices {

  StreamController<String> streamController = StreamController<String>.broadcast();
  Stream<String> get stream => streamController.stream;

  Future<bool> checkServerConnection() async {
    Dio dio = Dio(BaseOptions(baseUrl: 'http://localhost:5000'));

    try {
      final response = await dio.get('http://localhost:5000/status');

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<List<String>> getScripts() async {
    Dio dio = Dio(BaseOptions(baseUrl: 'http://localhost:5000'));

    try {
      final response = await dio.get('http://localhost:5000/scripts');

      if (response.statusCode == 200) {
        return List<String>.from(response.data['scripts']);
      }
    } catch (e) {
      log("Error loading scripts");
    }

    log("error in getscripts function");
    return [];
  }

  Future<void> runScript(String script) async {
    if (script.isEmpty) {
      log("no script");
      return;
    }

    Dio dio = Dio(BaseOptions(baseUrl: 'http://localhost:5000'));
    log(script);

    try {
      final response = await dio.post(
        'http://localhost:5000/run',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
          responseType: ResponseType.stream,
        ),
        data: {
          'script': script,
        },
      );

      if (response.statusCode == 200) {
        final responseStream = response.data.stream;

        await for (final value in responseStream) {
          String text;
          text = utf8.decode(value);

          streamController.add(text);
        }

      }
    } catch (e) {
      //streamController.close();
      rethrow;
    }
    //streamController.close();
  }

  Future<void> stopScript() async {
    Dio dio = Dio(BaseOptions(baseUrl: 'http://localhost:5000'));

    try {
      await dio.post(
        'http://localhost:5000/stop',
      );
      //show stop signal message
    } catch (e) {
      log("error stopping");
    }
  }
}
