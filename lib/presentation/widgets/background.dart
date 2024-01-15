import 'package:atlas_web/core/app/app_export.dart';
import 'package:atlas_web/core/responsive.dart';

import '../../../core/colors_manager.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height,
      width: context.width,
      color: kbBackgroundColor,
      child: Stack(
        children: [
          !Responsive.isMobile(context)
              ? Positioned(
                  bottom: 0,
                  child: Image.asset(
                    "assets/icon/background.png",
                    color: ColorConstant.primaryColor,
                    fit: BoxFit.cover,
                  ),
                )
              : const SizedBox.shrink(),
          SafeArea(child: child)
        ],
      ),
    );
  }
}
