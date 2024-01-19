class TranscriptionResponse {
  String? status;
  String? message;
  TranscriptionResponseData? data;

  TranscriptionResponse({this.status, this.message, this.data});

  TranscriptionResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? TranscriptionResponseData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class TranscriptionResponseData {
  String? script;
  String? translation;

  TranscriptionResponseData({this.script, this.translation});

  TranscriptionResponseData.fromJson(Map<String, dynamic> json) {
    script = json['script'];
    translation = json['translation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['script'] = script;
    data['translation'] = translation;
    return data;
  }
}
