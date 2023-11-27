
import 'package:file_picker/file_picker.dart';

pickVideoFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.video,
    allowMultiple: false,
  );

  if (result != null) {
    PlatformFile file = result.files.first;

    return file;
  } else {
    return null;
  }
}

pickAudioFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.audio,
    allowMultiple: false,
  );

  if (result != null) {
    PlatformFile file = result.files.first;
    return file;
  } else {
    return null;
  }
}