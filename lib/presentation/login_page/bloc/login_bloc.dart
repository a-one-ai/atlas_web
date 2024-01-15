import 'dart:async';

import 'package:atlas_web/core/data/models/login/post_login_req.dart';
import 'package:atlas_web/core/data/models/login/post_login_resp.dart';
import 'package:atlas_web/core/data/repository/repository.dart';
import 'package:atlas_web/core/utils/pref_utils.dart';
import 'package:atlas_web/presentation/login_page/models/login_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(super.initialState) {
    on<LoginInitialEvent>(_onInitialize);
    on<ChangePasswordVisibilityEvent>(_changePasswordVisibility);
    on<CreateLoginEvent>(_callCreateLogin);
    on<UpdateFormProgressEvent>(_updateFormProgress);
  }

  final _repository = Repository();

  PostLoginResp postLoginResp = PostLoginResp();

  _changePasswordVisibility(
    ChangePasswordVisibilityEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(isShowPassword: event.value));
  }

  _onInitialize(
    LoginInitialEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(
        emailController: TextEditingController(),
        passwordController: TextEditingController(),
        isShowPassword: true));
  }

  FutureOr<void> _callCreateLogin(
    CreateLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    PostLoginReq postLoginReq = PostLoginReq(
      email: state.emailController?.text ?? '',
      password: state.passwordController?.text ?? '',
    );
    await _repository.createLogin(user: postLoginReq).then((value) async {
      postLoginResp = value;
      _onCreateLoginSuccess(value, emit);
      event.onCreateLoginEventSuccess.call();
    }).onError((error, stackTrace) {
      //implement error call
      _onCreateLoginError();
      event.onCreateLoginEventError.call();
    });
  }

  void _onCreateLoginSuccess(
    PostLoginResp resp,
    Emitter<LoginState> emit,
  ) {
    PrefUtils().setId(resp.data?.id ?? '');
    PrefUtils().setName(resp.data?.name ?? '');
    emit(
      state.copyWith(
        loginModelObj: state.loginModelObj?.copyWith(),
      ),
    );
  }

  void _updateFormProgress(
    UpdateFormProgressEvent event,
    Emitter<LoginState> emit,
  ) {
    var progress = 0.0;
    final controllers = [state.emailController, state.passwordController];

    for (final controller in controllers) {
      if (controller?.value.text.isNotEmpty ?? false) {
        progress += 1 / controllers.length;
      }
    }

    emit(
      state.copyWith(formProgress: progress),
    );
  }

  void _onCreateLoginError() {
    //implement error method body...
  }
}
