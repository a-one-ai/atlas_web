part of 'result_page_bloc.dart';

abstract class ResultPageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UploadAudioInitialEvent extends ResultPageEvent {}

class UploadFile extends ResultPageEvent {
  final Function onUploadFileEventSuccess;
  final Function onUploadFileEventError;
  UploadFile({
    required this.onUploadFileEventSuccess,
    required this.onUploadFileEventError,
  });
  @override
  List<Object?> get props => [onUploadFileEventSuccess, onUploadFileEventError];
}
