part of 'upload_audio_bloc.dart';

class UploadAudioState extends Equatable {
  const UploadAudioState({this.response, this.request = Request.initial});

  final Request? request;
  final TranscriptionResponse? response;

  @override
  List<Object?> get props => [request, response];
  UploadAudioState copyWith(
      {Request? request, TranscriptionResponse? response}) {
    return UploadAudioState(
      request: request ?? this.request,
      response: response ?? this.response,
    );
  }
}
