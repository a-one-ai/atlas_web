import 'package:atlas_web/core/app/app_export.dart';
import 'package:atlas_web/presentation/landing_page/bloc/landing_bloc.dart';
import 'package:atlas_web/presentation/landing_page/widgets/action_card_widget.dart';
import 'package:atlas_web/presentation/widgets/background.dart';
import 'package:atlas_web/presentation/widgets/logo_widget.dart';
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
            const LogoWidget(),
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
                          onTap: () => context.go(AppRoutes.uploadVideoRoute),
                          icon: Icons.videocam,
                          title: "lbl_video".tr,
                          color: ColorConstant.indigoColor,
                        ),
                        ActionCardWidget(
                          onTap: () => context.go(AppRoutes.uploadLinkRoute),
                          icon: Icons.play_circle_outline,
                          title: "lbl_link".tr,
                          color: ColorConstant.darkRedColor,
                        ),
                        ActionCardWidget(
                          onTap: () => context.go(AppRoutes.uploadAudioRoute),
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
