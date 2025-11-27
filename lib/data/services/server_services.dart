import 'dart:developer';

import 'package:dio/dio.dart';

class ServerServices {
  Future<bool> isConnected() async {
    Dio dio = Dio(BaseOptions(baseUrl: 'http://localhost:5000'));

    try {
      final response = await dio.get('http://localhost:5000/status');

      if (response.statusCode == 200) {
        //loadScripts();
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

    if(script.isEmpty) {
      log("no script");
      return;
    }

    //isrunning = true

    Dio dio = Dio(BaseOptions(baseUrl: 'http://localhost:5000'));

    try {
      final response = await dio.post(
        'http://localhost:5000/run',
        data: {
          'scripts': script,
        }
      );

      if(response.statusCode == 200) {
        log("running");
      }
    } catch (e) {
      log("script run error");
    } finally {
      //isrunning = false
    } 
  }
}
