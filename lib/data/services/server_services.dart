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

  Future<void> runScript(List<String> agentScripts) async {
    // if (agent1.isEmpty || agent2.isEmpty || agent3.isEmpty) {
    //   throw "Empty Script";
    // }

    

    Dio dio = Dio(BaseOptions(baseUrl: 'http://localhost:5000'));

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
          'scripts': agentScripts,
        },
      );
      if (response.statusCode == 200) {
        log("Running");
        final responseStream = response.data.stream;

        await for (final value in responseStream) {
          String text;
          text = utf8.decode(value);
          log(text.toString());
          streamController.add(text);
        }
        log("stopping");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> stopScript() async {
    Dio dio = Dio(BaseOptions(baseUrl: 'http://localhost:5000'));

    try {
      await dio.post(
        'http://localhost:5000/stop',
      );

      log("stopping");
    } catch (e) {
      rethrow;
    }
  }
}
