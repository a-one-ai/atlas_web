import 'dart:html' as html;
import 'dart:convert';
import 'dart:typed_data';

// Inside _ResultScreenState

void saveToFile(String fileName, String content) {
  // Convert content to a Uint8List
  List<int> bytes = utf8.encode(content);

  // Create a Blob
  final blob = html.Blob([Uint8List.fromList(bytes)], 'text/plain');

  // Create a temporary URL to the blob
  final url = html.Url.createObjectUrlFromBlob(blob);

  // Create an anchor element
  final anchor = html.AnchorElement(href: url)
    ..setAttribute("download", fileName)
    ..click();

  // Clean up by revoking the URL
  html.Url.revokeObjectUrl(url);
}


String generateSrt(List scriptTime) {
  String srtContent = '';
  int count = 1;

  for (String timestampLine in scriptTime) {
    List<String> parts = timestampLine.split('   ');
    String timestamps = parts[0];
    String dialogue = parts[1];
    List<String> timeRange = timestamps.split(' - ');

    srtContent += '$count\n';
    srtContent +=
    '${timeRange[0].replaceFirst('.', ',')} --> ${timeRange[1].replaceFirst('.', ',')}\n';
    srtContent += '${dialogue.trim()}\n\n';
    count++;
  }

  return srtContent;
}


