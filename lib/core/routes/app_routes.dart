import 'dart:developer';

import 'package:atlas_web/core/app/app_export.dart';
import 'package:atlas_web/core/utils/image_constant.dart';
import 'package:atlas_web/core/utils/pref_utils.dart';
import 'package:atlas_web/presentation/landing_page/landing_page.dart';
import 'package:atlas_web/presentation/login_page/login_page.dart';
import 'package:atlas_web/presentation/upload_audio/upload_audio_page.dart';
import 'package:atlas_web/presentation/upload_link/upload_link_page.dart';
import 'package:atlas_web/presentation/upload_video/upload_video_page.dart';
import 'package:atlas_web/presentation/widgets/custom_image_view.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const String initialRoute = '/';
  static const String loginPageRoute = '/login';
  static const String landingPageRoute = '/landing';
  static const String uploadAudioRoute = '/uploadAudio';
  static const String uploadVideoRoute = '/uploadVideo';
  static const String uploadLinkRoute = '/uploadLink';

  static final GoRouter goRouter = GoRouter(
    errorBuilder: (context, state) => Scaffold(
        body: Center(
      child: CustomImageView(
          svgPath: ImageConstant.page404, alignment: Alignment.center),
    )),
    debugLogDiagnostics: true,
    navigatorKey: NavigatorService.navigatorKey,
    redirect: (context, state) {
      final isLoggedIn = PrefUtils().getId().isNotEmpty;
      log('isLoggedIn: $isLoggedIn');
      if (!isLoggedIn) return loginPageRoute;

      return null;
    },
    routes: [
      GoRoute(
        path: initialRoute,
        builder: (context, state) => LandingPage.builder(context),
      ),
      GoRoute(
          path: loginPageRoute,
          builder: (context, state) => LoginPage.builder(context),
          redirect: (context, state) {
            final isLoggedIn = PrefUtils().getId().isNotEmpty;
            log('isLoggedIn: $isLoggedIn');
            if (!isLoggedIn) return loginPageRoute;
            if (isLoggedIn) return landingPageRoute;

            return null;
          }),
      GoRoute(
        path: landingPageRoute,
        builder: (context, state) => LandingPage.builder(context),
      ),
      GoRoute(
        path: uploadAudioRoute,
        builder: (context, state) => UploadAudioPage.builder(context),
      ),
      GoRoute(
        path: uploadVideoRoute,
        builder: (context, state) => UploadVideoPage.builder(context),
      ),
      GoRoute(
        path: uploadLinkRoute,
        builder: (context, state) => UploadLinkPage.builder(context),
      ),
    ],
  );
}
