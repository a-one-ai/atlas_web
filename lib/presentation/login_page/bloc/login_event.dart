// ignore_for_file: must_be_immutable

part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitialEvent extends LoginEvent {}

class CreateLoginEvent extends LoginEvent {
  CreateLoginEvent({
    required this.onCreateLoginEventSuccess,
    required this.onCreateLoginEventError,
  });

  Function onCreateLoginEventSuccess;

  Function onCreateLoginEventError;

  @override
  List<Object?> get props =>
      [onCreateLoginEventSuccess, onCreateLoginEventError];
}

class UpdateFormProgressEvent extends LoginEvent {}

///event for change password visibility
class ChangePasswordVisibilityEvent extends LoginEvent {
  ChangePasswordVisibilityEvent({required this.value});

  bool value;

  @override
  List<Object?> get props => [value];
}
