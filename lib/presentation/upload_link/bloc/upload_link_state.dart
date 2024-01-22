part of 'upload_link_bloc.dart';

class UploadLinkState extends Equatable {
  const UploadLinkState({
    this.response,
    this.request = Request.initial,
    this.linkController,
    this.urlValid = false,
    this.translate = false,
  });

  final Request? request;
  final TranscriptionResponse? response;
  final TextEditingController? linkController;
  final bool? urlValid;
  final bool? translate;

  @override
  List<Object?> get props =>
      [request, response, linkController, urlValid, translate];
  UploadLinkState copyWith(
      {Request? request,
      TranscriptionResponse? response,
      TextEditingController? linkController,
      bool? urlValid,
      bool? translate}) {
    return UploadLinkState(
      request: request ?? this.request,
      response: response ?? this.response,
      linkController: linkController ?? this.linkController,
      urlValid: urlValid ?? this.urlValid,
      translate: translate ?? this.translate,
    );
  }
}
