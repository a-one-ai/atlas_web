import 'package:atlas_web/core/data/api_client/api_client.dart';
import 'package:atlas_web/core/data/models/login/post_login_req.dart';
import 'package:atlas_web/core/data/models/login/post_login_resp.dart';
import 'package:atlas_web/core/data/models/register/post_register_req.dart';
import 'package:atlas_web/core/data/models/register/post_register_resp.dart';
import 'package:atlas_web/core/di/injector.dart';
import 'package:atlas_web/model/transcription_response.dart';
import 'package:file_picker/file_picker.dart';

class Repository {
  final ApiClient _apiClient = getIt<ApiClient>();

  Future<PostLoginResp> createLogin({required PostLoginReq user}) async =>
      await _apiClient.createLogin(user: user);
  Future<PostRegisterResp> createRegister(
          {required PostRegisterReq postRegisterReq}) async =>
      await _apiClient.createRegister(user: postRegisterReq);
  Future<TranscriptionResponse> uploadYoutubeLink(
          {required String link,
          required bool translate,
          required String language}) async =>
      await _apiClient.uploadYoutubeLink(
          link: link, translate: translate, language: language);
  Future<TranscriptionResponse> uploadAudio(
          {required PlatformFile selectedFile}) async =>
      await _apiClient.uploadAudio(selectedFile: selectedFile);
}
