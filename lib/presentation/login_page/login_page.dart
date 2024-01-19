import 'package:atlas_web/core/utils/image_constant.dart';
import 'package:atlas_web/presentation/login_page/bloc/login_bloc.dart';
import 'package:atlas_web/presentation/login_page/models/login_model.dart';
import 'package:atlas_web/presentation/widgets/background.dart';
import 'package:atlas_web/presentation/widgets/custom_button.dart';
import 'package:atlas_web/presentation/widgets/custom_image_view.dart';
import 'package:atlas_web/presentation/widgets/custom_text_form_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../core/app/app_export.dart';

class LoginPage extends StatefulWidget {
  static Widget builder(BuildContext context) {
    return BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(LoginState(loginModelObj: LoginModel()))
          ..add(LoginInitialEvent()),
        child: const LoginPage());
  }

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FocusNode emailFocusNode = FocusNode();

  final FocusNode passwordFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Form(
          onChanged: () =>
              context.read<LoginBloc>().add(UpdateFormProgressEvent()),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                height: height * 0.55,
                width: height * 0.9,
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                margin: getMargin(all: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                        color: ColorConstant.primaryColor, width: 1.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /// heading
                    SizedBox(height: height * 0.024),
                    Row(
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

                    BlocSelector<LoginBloc, LoginState, TextEditingController?>(
                        selector: (state) => state.emailController,
                        builder: (context, nameController) {
                          return CustomTextFormField(
                              variant: TextFormFieldVariant.OutlinePrimary,
                              shape: TextFormFieldShape.RoundedBorder5,
                              focusNode: emailFocusNode,
                              controller: nameController,
                              textInputType: TextInputType.emailAddress,
                              hintText: "lbl_email".tr,
                              margin: getMargin(top: 49));
                        }),
                    BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                      return CustomTextFormField(
                          variant: TextFormFieldVariant.OutlinePrimary,
                          shape: TextFormFieldShape.RoundedBorder5,
                          focusNode: passwordFocusNode,
                          controller: state.passwordController,
                          hintText: "lbl_password".tr,
                          margin: getMargin(top: 20),
                          padding: TextFormFieldPadding.PaddingT14,
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.visiblePassword,
                          suffix: InkWell(
                              onTap: () => context.read<LoginBloc>().add(
                                  ChangePasswordVisibilityEvent(
                                      value: state.isShowPassword == false)),
                              child: Container(
                                  margin: getMargin(all: 10),
                                  child: Icon(
                                    (state.isShowPassword)
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey.shade500,
                                  ))),
                          suffixConstraints:
                              BoxConstraints(maxHeight: getVerticalSize(52)),
                          isObscureText: state.isShowPassword);
                    }),

                    BlocSelector<LoginBloc, LoginState, double?>(
                      selector: (state) => state.formProgress,
                      builder: (context, formProgress) {
                        return CustomButton(
                          height: getVerticalSize(50),
                          text: "lbl_login".tr,
                          margin: getMargin(top: 30),
                          shape: ButtonShape.RoundedBorder7,
                          disabled: formProgress != 1,
                          onTap: () => onTapLogin(context),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  onTapLogin(BuildContext context) {
    context.read<LoginBloc>().add(
          CreateLoginEvent(
            onCreateLoginEventSuccess: () {
              _onCreateLoginEventSuccess(context);
            },
            onCreateLoginEventError: () {
              _onCreateLoginEventError();
            },
          ),
        );
  }

  void _onCreateLoginEventSuccess(BuildContext context) =>
      context.go(AppRoutes.landingPageRoute);

  void _onCreateLoginEventError() => Fluttertoast.showToast(
        webBgColor: "linear-gradient(to right, #311B92, #311B92)",
        msg: "msg_invalid_username_or_password".tr,
      );
}
