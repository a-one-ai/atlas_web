import 'package:atlas_web/core/utils/responsive.dart';
import 'package:atlas_web/model/transcription_response.dart';
import 'package:atlas_web/presentation/result/result_page.dart';
import 'package:atlas_web/presentation/upload_link/bloc/upload_link_bloc.dart';
import 'package:atlas_web/presentation/widgets/custom_button.dart';
import 'package:atlas_web/presentation/widgets/main_upload_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../core/app/app_export.dart';
import 'widgets/custom_drop_down.dart';

class UploadLinkPage extends StatefulWidget {
  static Widget builder(BuildContext context) {
    return BlocProvider<UploadLinkBloc>(
        create: (context) => UploadLinkBloc(const UploadLinkState())
          ..add(UploadAudioInitialEvent()),
        child: const UploadLinkPage());
  }

  const UploadLinkPage({Key? key}) : super(key: key);

  @override
  State<UploadLinkPage> createState() => _UploadLinkPageState();
}

class _UploadLinkPageState extends State<UploadLinkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainUploadWidget(
          color: ColorConstant.darkRedColor,
          child: BlocSelector<UploadLinkBloc, UploadLinkState, Request?>(
              selector: (state) => state.request,
              builder: (context, request) {
                if (request == Request.loading) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: LoadingAnimationWidget.dotsTriangle(
                      color: ColorConstant.darkRedColor,
                      size: 200,
                    ),
                  );
                }
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 40),
                      width: !Responsive.isMobile(context)
                          ? context.width / 2.5
                          : null,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BlocSelector<UploadLinkBloc, UploadLinkState,
                              TextEditingController?>(
                            selector: (state) => state.linkController,
                            builder: (context, controller) {
                              return TextFormField(
                                controller: controller,
                                decoration: InputDecoration(
                                  hintText: "lbl_enter_link".tr,
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    borderSide: BorderSide(
                                        color: ColorConstant.darkRedColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: ColorConstant
                                            .darkRedColor // Change focus color
                                        ),
                                  ),
                                ),
                                onFieldSubmitted: (value) => context
                                    .read<UploadLinkBloc>()
                                    .add(CheckForUrl(text: value)),
                                onChanged: (value) => context
                                    .read<UploadLinkBloc>()
                                    .add(CheckForUrl(text: value)),
                              );
                            },
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            width: !Responsive.isMobile(context)
                                ? context.width / 2.5
                                : null,
                            child: BlocSelector<UploadLinkBloc, UploadLinkState,
                                String?>(
                              selector: (state) => state.languageFrom,
                              builder: (context, category) {
                                return CustomDropDownWidget(
                                  initialItem: category,
                                  items: const [
                                    "german",
                                    "hebrew",
                                    "english",
                                    "arabic",
                                    "french"
                                  ],
                                  onChange: (String? value) => context
                                      .read<UploadLinkBloc>()
                                      .add(ChangeLanguageFrom(
                                          language: value ?? '')),
                                  hintText: "Language from",
                                );
                              },
                            ),
                          ),
                          BlocSelector<UploadLinkBloc, UploadLinkState, bool?>(
                            selector: (state) => state.translate,
                            builder: (context, status) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: CheckboxListTile(
                                  activeColor: ColorConstant.primaryColor,
                                  value: status,
                                  onChanged: (value) => context
                                      .read<UploadLinkBloc>()
                                      .add(ChangeTranslationStatus(
                                          status: value ?? false)),
                                  title: Text("${"lbl_translate".tr}?"),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    BlocSelector<UploadLinkBloc, UploadLinkState, bool?>(
                      selector: (state) => state.urlValid,
                      builder: (_, valid) {
                        return CustomButton(
                          onTap: () => onTapStart(context),
                          height: 60.0,
                          width: 280.0,
                          variant: ButtonVariant.fillDarkRed,
                          text: "lbl_start_transcription".tr,
                          disabled: valid == false,
                        );
                      },
                    ),
                  ],
                );
              })),
    );
  }

  onTapStart(BuildContext context) {
    context.read<UploadLinkBloc>().add(
          UploadLink(
            onUploadLinkEventSuccess: (TranscriptionResponse response) =>
                _onUploadLinkEventSuccess(context, response),
            onUploadLinkEventError: () => _onUploadLinkEventError(),
          ),
        );
  }

  void _onUploadLinkEventSuccess(
      BuildContext context, TranscriptionResponse response) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(
              results: response, color: ColorConstant.darkRedColor),
        ));
  }

  void _onUploadLinkEventError() => Fluttertoast.showToast(
        webBgColor: "linear-gradient(to right, #B31312, #B31312)",
        msg: "lbl_error".tr,
      );
}
