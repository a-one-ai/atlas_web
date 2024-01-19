import 'package:atlas_web/core/utils/image_constant.dart';
import 'package:atlas_web/presentation/widgets/custom_image_view.dart';

import '../../core/app/app_export.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getSize(200),
      height: getSize(200),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
              height: height * 0.1,
              svgPath: ImageConstant.appLogo,
              alignment: Alignment.center),
          Text(
            'ATLAS',
            style: TextStyle(
                fontSize: 20.0,
                color: ColorConstant.primaryColor,
                fontWeight: FontWeight.w900),
          )
        ],
      ),
    );
  }
}
