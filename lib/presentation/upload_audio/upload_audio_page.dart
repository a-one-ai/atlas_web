import 'package:atlas_web/core/app/app_export.dart';
import 'package:atlas_web/core/utils/image_constant.dart';
import 'package:atlas_web/presentation/upload_audio/bloc/upload_audio_bloc.dart';
import 'package:atlas_web/presentation/widgets/custom_image_view.dart';
import 'package:atlas_web/presentation/widgets/main_upload_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../model/transcription_response.dart';

import '../result/result_page.dart';

class UploadAudioPage extends StatefulWidget {
  static Widget builder(BuildContext context) {
    return BlocProvider<UploadAudioBloc>(
        create: (context) => UploadAudioBloc(const UploadAudioState())
          ..add(UploadAudioInitialEvent()),
        child: const UploadAudioPage());
  }

  const UploadAudioPage({Key? key}) : super(key: key);

  @override
  State<UploadAudioPage> createState() => _UploadAudioPageState();
}

class _UploadAudioPageState extends State<UploadAudioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainUploadWidget(
          color: ColorConstant.darkOrangeColor,
          child: BlocSelector<UploadAudioBloc, UploadAudioState, Request?>(
              selector: (state) => state.request,
              builder: (context, request) {
                if (request == Request.loading) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 60),
                      Container(
                        width: 250,
                        height: 150,
                        padding: const EdgeInsets.all(40),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: ColorConstant.darkOrangeColor,
                        ),
                        child: Center(
                          child: LoadingAnimationWidget.staggeredDotsWave(
                              color: Colors.white, size: 150),
                        ),
                      ),
                    ],
                  );
                }
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 60),
                    InkWell(
                      onTap: () => onTapUpload(context),
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        width: 250,
                        height: 150,
                        decoration: BoxDecoration(
                            color: ColorConstant.darkOrangeColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CustomImageView(
                                  height: 70,
                                  width: 70,
                                  svgPath: ImageConstant.cloudUpload),
                              const SizedBox(height: 10),
                              const Text(
                                'Click to Upload',
                                style: TextStyle(
                                    fontSize: 14, color: Color(0xFFFFFFFF)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              })),
    );
  }

  onTapUpload(BuildContext context) {
    context.read<UploadAudioBloc>().add(
          UploadFile(
            onUploadFileEventSuccess: () {
              _onUploadFileEventSuccess(context);
            },
            onUploadFileEventError: () {
              _onUploadFileEventError(context);
            },
          ),
        );
  }

  void _onUploadFileEventSuccess(BuildContext context) {
    TranscriptionResponse? response =
        context.read<UploadAudioBloc>().state.response;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          results: response ?? TranscriptionResponse(),
          color: ColorConstant.darkOrangeColor,
        ),
      ),
    );
  }

  void _onUploadFileEventError(BuildContext context) {}
}
