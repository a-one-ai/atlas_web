import 'dart:async';
import 'dart:developer';

import 'package:atlas_web/core/data/api_client/api_client.dart';
import 'package:atlas_web/core/di/injector.dart';
import 'package:atlas_web/core/utils/logger.dart';
import 'package:atlas_web/core/utils/pref_utils.dart';
import 'package:flutter/foundation.dart';

import 'core/app/app_export.dart';
import 'core/utils/web_config.dart';

/// A global key to access the state of [ScaffoldMessenger] widget from anywhere
/// in the application.
GlobalKey<ScaffoldMessengerState> globalMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

Future<void> boot() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError =
      (details) => log(details.exceptionAsString(), stackTrace: details.stack);

  Bloc.observer = AppBlocObserver();

  configInjector();

  await ApiClient.initializeFirebase();
  configureWeb();

  PrefUtils().init();
  Logger.init(kReleaseMode ? LogMode.live : LogMode.debug);
  runApp(const App());
}
