part of 'upload_audio_bloc.dart';

abstract class UploadAudioEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UploadAudioInitialEvent extends UploadAudioEvent {}

class UploadFile extends UploadAudioEvent {
  final Function onUploadFileEventSuccess;
  final Function onUploadFileEventError;
  UploadFile({
    required this.onUploadFileEventSuccess,
    required this.onUploadFileEventError,
  });
  @override
  List<Object?> get props => [onUploadFileEventSuccess, onUploadFileEventError];
}
