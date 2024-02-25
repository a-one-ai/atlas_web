import 'package:atlas_web/core/data/repository/repository.dart';
import 'package:atlas_web/model/transcription_response.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

import '../../../core/app/app_export.dart';

part 'upload_video_event.dart';
part 'upload_video_state.dart';

class UploadVideoBloc extends Bloc<UploadVideoEvent, UploadVideoState> {
  UploadVideoBloc(super.initialState) {
    on<UploadAudioInitialEvent>(_onInitialize);
    on<UploadFile>(_onUploadFile);
  }

  final _repository = Repository();

  _onInitialize(
    UploadAudioInitialEvent event,
    Emitter<UploadVideoState> emit,
  ) {}
  _onUploadFile(
    UploadFile event,
    Emitter<UploadVideoState> emit,
  ) async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.audio, allowMultiple: false);

    if (result != null) {
      PlatformFile file = result.files.first;

      emit(state.copyWith(request: Request.loading));
      await _repository.uploadVideo(selectedFile: file).then((value) {
        event.onUploadFileEventSuccess.call();
        emit(state.copyWith(request: Request.success, response: value));
      }).onError((error, stackTrace) {
        event.onUploadFileEventError.call();
        emit(state.copyWith(request: Request.failed));
      });
    }
  }
}
