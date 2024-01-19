part of 'upload_video_bloc.dart';

class UploadVideoState extends Equatable {
  const UploadVideoState({this.response, this.request = Request.initial});

  final Request? request;
  final TranscriptionResponse? response;

  @override
  List<Object?> get props => [request, response];
  UploadVideoState copyWith(
      {Request? request, TranscriptionResponse? response}) {
    return UploadVideoState(
      request: request ?? this.request,
      response: response ?? this.response,
    );
  }
}
