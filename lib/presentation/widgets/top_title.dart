import 'package:atlas_web/core/utils/image_constant.dart';
import 'package:atlas_web/presentation/widgets/custom_image_view.dart';

import '../../core/app/app_export.dart';

class TopMenu extends StatelessWidget {
  const TopMenu({Key? key, this.iconColor = Colors.deepPurple})
      : super(key: key);

  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
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
    );
  }
}
