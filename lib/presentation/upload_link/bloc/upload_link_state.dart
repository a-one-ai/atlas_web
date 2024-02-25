part of 'upload_link_bloc.dart';

class UploadLinkState extends Equatable {
  const UploadLinkState(
      {this.response,
      this.request = Request.initial,
      this.linkController,
      this.urlValid = false,
      this.translate = false,
      this.languageFrom = "english"});

  final Request? request;
  final TranscriptionResponse? response;
  final TextEditingController? linkController;
  final bool? urlValid;
  final bool? translate;
  final String? languageFrom;

  @override
  List<Object?> get props =>
      [request, response, linkController, urlValid, translate, languageFrom];
  UploadLinkState copyWith(
      {Request? request,
      TranscriptionResponse? response,
      TextEditingController? linkController,
      bool? urlValid,
      bool? translate,
      String? languageFrom}) {
    return UploadLinkState(
      request: request ?? this.request,
      response: response ?? this.response,
      linkController: linkController ?? this.linkController,
      urlValid: urlValid ?? this.urlValid,
      translate: translate ?? this.translate,
      languageFrom: languageFrom ?? this.languageFrom,
    );
  }
}
