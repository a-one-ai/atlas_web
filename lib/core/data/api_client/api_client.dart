import 'dart:convert';

import 'package:atlas_web/core/data/models/login/post_login_req.dart';
import 'package:atlas_web/core/data/models/login/post_login_resp.dart';
import 'package:atlas_web/core/data/models/register/post_register_req.dart';
import 'package:atlas_web/core/data/models/register/post_register_resp.dart';
import 'package:atlas_web/core/utils/logger.dart';
import 'package:atlas_web/core/utils/progress_dialog_utils.dart';
import 'package:atlas_web/firebase_options.dart';
import 'package:atlas_web/model/transcription_response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class ApiClient {
  // Initialize Firebase
  static Future<void> initializeFirebase() async {
    if (kIsWeb) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } else {
      await Firebase.initializeApp();
    }
  }

  // Initialize Dio
  final Dio _dio = Dio();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Dio get dio => _dio;
  FirebaseAuth get auth => _auth;
  FirebaseFirestore get firestore => _firestore;
  FirebaseAuth get firebaseAuth => _firebaseAuth;

  final String _mainUrl =
      'https://us-central1-atlas-7f720.cloudfunctions.net/serverrequests-api';

  Future<PostLoginResp> createLogin({required PostLoginReq user}) async {
    try {
      ProgressDialogUtils.showProgressDialog();

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);

      // Retrieve user data from Firestore
      DocumentSnapshot snapshot = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      ProgressDialogUtils.hideProgressDialog();

      PostLoginRespData loginData = PostLoginRespDataMapper.fromMap(
          snapshot.data() as Map<String, dynamic>);

      loginData.id = userCredential.user!.uid;

      if (snapshot.exists) {
        return PostLoginResp(data: loginData);
      } else {
        return PostLoginResp();
      }
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(
        error.toString(),
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<PostRegisterResp> createRegister(
      {required PostRegisterReq user}) async {
    try {
      ProgressDialogUtils.showProgressDialog();

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: user.email ?? '',
        password: user.password ?? '',
      );

      Map<String, dynamic> currentUser = user.toJson();

      currentUser['id'] = userCredential.user!.uid;

      await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(currentUser, SetOptions(merge: true));

      ProgressDialogUtils.hideProgressDialog();

      PostRegisterResp postRegisterResp = PostRegisterResp(
          data: Data(
              name: user.name,
              email: user.email,
              password: user.password,
              id: userCredential.user!.uid,
              role: user.role,
              username: user.username,
              profile: user.profile));
      return postRegisterResp;
    } catch (error, stackTrace) {
      ProgressDialogUtils.hideProgressDialog();
      Logger.log(
        error.toString(),
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<TranscriptionResponse> uploadYoutubeLink(
      {required String link,
      required bool translate,
      required String language}) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};

    Map<String, dynamic> body = {"link": link, "lang": language};

    if (translate) {
      body["tr"] = "True";
    } else {
      body["tr"] = "False";
    }

    String data = json.encode(body);
    Dio dio = Dio();
    Response response = await dio.request(
      '$_mainUrl/getYoutubeVideoLink',
      options: Options(method: 'POST', headers: headers),
      data: data,
    );

    if (response.statusCode == 200) {
      return TranscriptionResponse.fromJson(response.data);
    } else {
      return TranscriptionResponse();
    }
  }

  Future<TranscriptionResponse> uploadAudio(
      {required PlatformFile selectedFile}) async {
    var headers = {'Content-Type': 'application/json'};

    var data = FormData.fromMap({
      'files': [
        MultipartFile.fromBytes(filename: 'audio', selectedFile.bytes ?? [])
      ],
    });

    var dio = Dio();
    var response = await dio.request(
      '$_mainUrl/getAudioFile',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      return TranscriptionResponse.fromJson(response.data);
    } else {
      return TranscriptionResponse();
    }
  }
}
