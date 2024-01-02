class SummaryResponse {
  Data? _data;

  SummaryResponse({Data? data}) {
    if (data != null) {
      _data = data;
    }
  }

  Data? get data => _data;
  set data(Data? data) => _data = data;

  SummaryResponse.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_data != null) {
      data['data'] = _data!.toJson();
    }
    return data;
  }
}

class Data {
  String? _arScript;
  String? _arSummary;
  String? _enScript;
  String? _enSummary;
  String? _script;

  Data(
      {String? arScript,
        String? arSummary,
        String? enScript,
        String? enSummary,
        String? script
       }) {
    if (arScript != null) {
      _arScript = arScript;
    }
    if (arSummary != null) {
      _arSummary = arSummary;
    }
    if (enScript != null) {
      _enScript = enScript;
    }
    if (enSummary != null) {
      _enSummary = enSummary;
    }
    if (script != null) {
      _script = script;
    }

  }

  String? get arScript => _arScript;
  set arScript(String? arScript) => _arScript = arScript;
  String? get arSummary => _arSummary;
  set arSummary(String? arSummary) => _arSummary = arSummary;
  String? get enScript => _enScript;
  set enScript(String? enScript) => _enScript = enScript;
  String? get enSummary => _enSummary;
  set enSummary(String? enSummary) => _enSummary = enSummary;
  String? get script => _script;
  set script(String? script) => _script = script;

  Data.fromJson(Map<String, dynamic> json) {
    _arScript = json['ar_script'];
    _arSummary = json['ar_summary'];
    _enScript = json['en_script'];
    _enSummary = json['en_summary'];
    _script = json['script'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ar_script'] = _arScript;
    data['ar_summary'] = _arSummary;
    data['en_script'] = _enScript;
    data['en_summary'] = _enSummary;
    data['script'] = _script;

    return data;
  }
}