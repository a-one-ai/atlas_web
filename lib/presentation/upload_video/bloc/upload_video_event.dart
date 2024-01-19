part of 'upload_video_bloc.dart';

abstract class UploadVideoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UploadAudioInitialEvent extends UploadVideoEvent {}

class UploadFile extends UploadVideoEvent {
  final Function onUploadFileEventSuccess;
  final Function onUploadFileEventError;
  UploadFile({
    required this.onUploadFileEventSuccess,
    required this.onUploadFileEventError,
  });
  @override
  List<Object?> get props => [onUploadFileEventSuccess, onUploadFileEventError];
}
