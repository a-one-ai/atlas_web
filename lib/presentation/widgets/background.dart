import 'package:atlas_web/core/app/app_export.dart';
import 'package:atlas_web/core/utils/image_constant.dart';
import 'package:atlas_web/core/utils/responsive.dart';
import 'package:atlas_web/presentation/widgets/custom_image_view.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({
    Key? key,
    required this.child,
    this.color,
  }) : super(key: key);

  final Widget child;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height,
      width: context.width,
      child: Stack(
        children: [
          !Responsive.isMobile(context)
              ? Positioned(
                  bottom: 0,
                  child: CustomImageView(
                    imagePath: ImageConstant.background,
                    fit: BoxFit.cover,
                    color: color ?? ColorConstant.primaryColor,
                  ),
                )
              : const SizedBox.shrink(),
          SafeArea(child: child),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 10),
              child: Text(
                '©2024 ATLAS',
                style: TextStyle(color: ColorConstant.primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
