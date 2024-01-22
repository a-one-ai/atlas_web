import 'package:atlas_web/core/data/repository/repository.dart';
import 'package:atlas_web/model/transcription_response.dart';
import 'package:equatable/equatable.dart';

import '../../../core/app/app_export.dart';

part 'upload_link_event.dart';
part 'upload_link_state.dart';

class UploadLinkBloc extends Bloc<UploadLinkEvent, UploadLinkState> {
  UploadLinkBloc(super.initialState) {
    on<UploadAudioInitialEvent>(_onInitialize);
    on<UploadLink>(_onUploadLink);
    on<CheckForUrl>(_onCheckForUrl);
    on<ChangeTranslationStatus>(_onChangeTranslationStatus);
  }

  final _repository = Repository();

  _onInitialize(
    UploadAudioInitialEvent event,
    Emitter<UploadLinkState> emit,
  ) {
    emit(state.copyWith(linkController: TextEditingController()));
  }

  _onUploadLink(
    UploadLink event,
    Emitter<UploadLinkState> emit,
  ) async {
    String link = state.linkController?.text ?? "";

    if (link.isNotEmpty) {
      emit(state.copyWith(request: Request.loading));
      await _repository
          .uploadYoutubeLink(link: link, translate: state.translate ?? false)
          .then((value) {
        event.onUploadLinkEventSuccess.call(value);
        emit(state.copyWith(request: Request.success, response: value));
      }).onError((error, stackTrace) {
        event.onUploadLinkEventError.call();
        emit(state.copyWith(request: Request.failed));
      });
    }
  }

  _onCheckForUrl(CheckForUrl event, Emitter<UploadLinkState> emit) {
    bool valid = false;

    if (event.text.contains("youtube")) {
      valid = true;
    }

    emit(state.copyWith(urlValid: valid));
  }

  _onChangeTranslationStatus(
      ChangeTranslationStatus event, Emitter<UploadLinkState> emit) {
    emit(state.copyWith(translate: event.status));
  }
}
