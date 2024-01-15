// ignore_for_file: must_be_immutable

part of 'login_bloc.dart';

class LoginState extends Equatable {
  LoginState(
      {this.emailController,
      this.passwordController,
      this.isShowPassword = true,
      this.loginModelObj,
      this.formProgress = 0.0});

  TextEditingController? emailController;

  TextEditingController? passwordController;

  LoginModel? loginModelObj;

  bool isShowPassword;

  double? formProgress;

  @override
  List<Object?> get props => [
        emailController,
        passwordController,
        isShowPassword,
        loginModelObj,
        formProgress,
      ];
  LoginState copyWith({
    TextEditingController? emailController,
    TextEditingController? passwordController,
    bool? isShowPassword,
    LoginModel? loginModelObj,
    double? formProgress,
  }) {
    return LoginState(
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      isShowPassword: isShowPassword ?? this.isShowPassword,
      loginModelObj: loginModelObj ?? this.loginModelObj,
      formProgress: formProgress ?? this.formProgress,
    );
  }
}
