part of 'upload_link_bloc.dart';

class UploadLinkState extends Equatable {
  const UploadLinkState({
    this.response,
    this.request = Request.initial,
    this.linkController,
    this.urlValid = false,
  });

  final Request? request;
  final TranscriptionResponse? response;
  final TextEditingController? linkController;
  final bool? urlValid;

  @override
  List<Object?> get props => [request, response, linkController, urlValid];
  UploadLinkState copyWith(
      {Request? request,
      TranscriptionResponse? response,
      TextEditingController? linkController,
      bool? urlValid}) {
    return UploadLinkState(
      request: request ?? this.request,
      response: response ?? this.response,
      linkController: linkController ?? this.linkController,
      urlValid: urlValid ?? this.urlValid,
    );
  }
}
