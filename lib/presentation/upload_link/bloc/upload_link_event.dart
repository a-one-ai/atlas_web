part of 'upload_link_bloc.dart';

abstract class UploadLinkEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UploadAudioInitialEvent extends UploadLinkEvent {}

class UploadLink extends UploadLinkEvent {
  final Function onUploadLinkEventSuccess;
  final Function onUploadLinkEventError;
  UploadLink({
    required this.onUploadLinkEventSuccess,
    required this.onUploadLinkEventError,
  });
  @override
  List<Object?> get props => [onUploadLinkEventSuccess, onUploadLinkEventError];
}

class CheckForUrl extends UploadLinkEvent {
  final String text;
  CheckForUrl({required this.text});
  @override
  List<Object?> get props => [text];
}

class ChangeTranslationStatus extends UploadLinkEvent {
  final bool status;
  ChangeTranslationStatus({required this.status});
  @override
  List<Object?> get props => [status];
}
