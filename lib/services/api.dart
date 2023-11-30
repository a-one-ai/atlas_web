import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '../../../model/response_model.dart';

class ApiService {
  late Dio _dio;
  String _mainUrl = 'http://184.105.217.223:8000';

  ApiService() {
    BaseOptions options = BaseOptions(
      baseUrl: _mainUrl,
      connectTimeout: Duration(seconds: 300),
      receiveTimeout: Duration(seconds: 300),
    );
    _dio = Dio(options);
  }

  Future<SummaryResponse> uploadStream(String text) async {
    try {
      log('Sending text to server: $text');
      var headers = {
        'Content-Type': 'application/json'
      };
      var data = {
        'link': text
      };
      var dio = Dio();
      var response = await dio.request(
        'http://184.105.217.223:8000/getYoutubeVideoLink',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        final summaryResponse = SummaryResponse.fromJson(response.data);
        return summaryResponse;
      } else {
        throw DioException(
          requestOptions: RequestOptions(path: '/getYoutubeVideoLink'),
          response: Response(
            statusCode: response.statusCode ?? -1,
            statusMessage: response.statusMessage ?? 'Unknown error',
            data: response.data,
            requestOptions: RequestOptions(path: '/getYoutubeVideoLink'),
          ),
        );
      }
    } on DioException catch (e) {
      print('Caught DioError: $e');
      rethrow; // Rethrow the DioError for upper-level handling
    } catch (e) {
      print('Caught generic error: $e');
      rethrow; // Rethrow other errors for upper-level handling
    }
  }

  Future<SummaryResponse> transcriptVideo( PlatformFile tempFile) async {
    try {
      FormData formData = FormData.fromMap({
        'video': MultipartFile.fromFile(
          tempFile.path!,
           )
      });

      final response = await _dio.post(
        '/getVideoFile',
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );

      if (response.statusCode == 200) {
        return SummaryResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to summarize video');
      }
    } catch (e) {
      print('Caught error: $e');
      rethrow;
    }
  }

  Future<SummaryResponse> transcriptAudio(PlatformFile tempFile) async {
    try {
      FormData formData = FormData.fromMap({
        'audio':  await MultipartFile.fromBytes(
          tempFile.bytes??[],
          filename: tempFile.name,

        ),
      });

      final response = await _dio.post(
        '/getAudioFile',
        data: formData,
      );

      if (response.statusCode == 200) {
        return SummaryResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to summarize audio');
      }
    } catch (e) {
      print('Caught error: $e');
      rethrow;
    }
  }
}