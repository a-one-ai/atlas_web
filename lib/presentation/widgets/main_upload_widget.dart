import 'package:atlas_web/core/app/app_export.dart';
import 'package:atlas_web/presentation/widgets/background.dart';
import 'package:atlas_web/presentation/widgets/logo_widget.dart';

class MainUploadWidget extends StatelessWidget {
  const MainUploadWidget({super.key, required this.child, required this.color});

  final Widget child;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Center(
        child: Column(
          children: <Widget>[
            const LogoWidget(),
            Text(
              "lbl_atlas_transcription".tr,
              style: TextStyle(
                  fontSize: 40, fontWeight: FontWeight.bold, color: color),
            ),
            const SizedBox(height: 20),
            Text(
              "lbl_atlas_transcription_description".tr,
              style: TextStyle(fontSize: 20, color: color),
            ),
            child
          ],
        ),
      ),
    );
  }
}
