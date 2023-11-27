import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

import '../../../model/response_model.dart';

class ApiService {
  late Dio _dio;
  String _mainUrl = 'http://184.105.215.243:8000';

  ApiService() {
    BaseOptions options = BaseOptions(
      baseUrl: _mainUrl,
      // connectTimeout: 5000,
      // receiveTimeout: 3000,
    );
    _dio = Dio(options);
  }

  Future<SummaryResponse> uploadStream(String text) async {
    try {
      final response = await _dio.post(
        '/getYoutubeVideoLink',
        data: {'link': text},
      );

      if (response.statusCode == 200) {
        return SummaryResponse.fromJson(response.data);
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
  Future<SummaryResponse> transcriptVideo(PlatformFile tempFile) async {
    try {
      FormData formData = FormData.fromMap({
        'video': MultipartFile.fromBytes(tempFile.bytes!),
      });

      final response = await _dio.post(
        '/getVideoFile',
        data: formData,
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

  Future<SummaryResponse> transcriptAudio( tempFile) async {
    try {
      FormData formData = FormData.fromMap({
        'audio': await MultipartFile.fromBytes(tempFile.bytes!),
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
