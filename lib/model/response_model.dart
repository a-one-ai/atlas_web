class SummaryResponse {
  final String arScript;
  final String enScript;
  final String arSummary;
  final String enSummary;
  final String scriptTime;

  SummaryResponse({
    required this.arScript,
    required this.enScript,
    required this.arSummary,
    required this.enSummary,
    required this.scriptTime,
  });

  factory SummaryResponse.fromJson(Map<String, dynamic> json) {
    return SummaryResponse(
      arScript: json['ar_script'],
      enScript: json['en_script'],
      arSummary: json['ar_summary'],
      enSummary: json['en_summary'],
      scriptTime: json['script_time'],
    );
  }
}
