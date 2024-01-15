import 'package:atlas_web/core/app/app_export.dart';
import 'package:atlas_web/core/utils/image_constant.dart';
import 'package:atlas_web/presentation/landing_page/bloc/landing_bloc.dart';
import 'package:atlas_web/presentation/landing_page/widgets/action_card_widget.dart';
import 'package:atlas_web/presentation/upload_audio/upload_audio_page.dart';
import 'package:atlas_web/presentation/upload_link/upload_link_page.dart';
import 'package:atlas_web/presentation/upload_video/upload_video_page.dart';
import 'package:atlas_web/presentation/widgets/background.dart';
import 'package:atlas_web/presentation/widgets/custom_image_view.dart';
import 'package:go_router/go_router.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<LandingBloc>(
        create: (context) =>
            LandingBloc(const LandingState())..add(LandingInitialEvent()),
        child: const LandingPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: getSize(200),
              height: getSize(200),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomImageView(
                    height: height * 0.1,
                    svgPath: ImageConstant.appLogo,
                    alignment: Alignment.center,
                    // color: Colors.grey[400],
                  ),
                  Text(
                    'ATLAS',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: ColorConstant.primaryColor,
                        fontWeight: FontWeight.w900),
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Center(
                  child: Padding(
                    padding: getPadding(all: 20),
                    child: Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: [
                        ActionCardWidget(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const UploadVideoPage()));
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => const DoneCasesScreen()),
                            // );
                          },
                          icon: Icons.videocam,
                          title: "lbl_video".tr,
                          color: ColorConstant.indigoColor,
                        ),
                        ActionCardWidget(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const UploadLinkPage()));

                            // context.go(AppRoutes.pendingCasesPageRoute);
                          },
                          icon: Icons.play_circle_outline,
                          title: "lbl_link".tr,
                          color: ColorConstant.darkRedColor,
                        ),
                        ActionCardWidget(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => UploadAudioPage()));
                            // context.go(AppRoutes.newCaseRoute);
                          },
                          icon: Icons.audiotrack,
                          title: "lbl_audio".tr,
                          color: ColorConstant.darkOrangeColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
